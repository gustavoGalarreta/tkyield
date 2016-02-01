  class Permit < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :receptor, :foreign_key => :receptor_id, :class_name => "User"
  validate :finish_cannot_be_earlier_than_start
  validates :start, presence: true
  validates :finish, presence: true
  after_create :send_permit_mail


  def get_status
    case self.status
    when 0
      return "reject"
    when 1
      return "accepted"
    when 2
      return "pending"
    end
  end

  def self.accepted_between_dates_and_user beginning, ending, user
    where(user: user, status: 1).where("start >= ? AND finish <= ?", beginning.beginning_of_day, ending.end_of_day)
  end

  def self.get_assitance_record_between_dates_and_user user, date
    assistance_per_month = Array.new(32)
    (0..32).each{ |day| 
      day_of_month = Hash.new
      day_of_month["permit"] = nil
      day_of_month["inTime"] = nil
      day_of_month["outTime"] = nil
      day_of_month["arrival"] = nil
      assistance_per_month[day] = day_of_month
    }
    Permit.accepted_between_dates_and_user(date.beginning_of_month,date.end_of_month,user).each { |current_permit|
      start = current_permit.start.strftime("%e").to_i
      finish = current_permit.finish.strftime("%e").to_i
      (start..finish).each { |day| 
          assistance_per_month[day]["permit"] = current_permit
        }
    }
    TimeStation.in_current_month_per_user(date, user).each { |current_timeStation|
      day = current_timeStation.created_at.strftime("%e").to_i
      if current_timeStation.parent_id?
        assistance_per_month[day]["outTime"] = current_timeStation
      else
        assistance_per_month[day]["inTime"] = current_timeStation
        assistance_per_month[day]["arrival"] = TimeStation.get_arrive_status(current_timeStation)
      end
    }
    return assistance_per_month
  end
  def self.search request, start, finish
    unless request.present?
      permits = Permit.all
    else
      permits = where(type_permits: request)
    end
    if start.present?
      permits = permits.where(["start >= ?", start.to_datetime.beginning_of_day])
    end
    if finish.present?
      permits = permits.where(["finish <= ?", finish.to_datetime.end_of_day])
    end
    return permits
  end

  def send_permit_mail
    TkYieldMailer.request_mail(self).deliver_later
  end

  private
    def finish_cannot_be_earlier_than_start
      unless start.nil? || finish.nil?
        time_error if finish.to_time < start.to_time
      end
    end

    def time_error
      errors.add(:time_error, 'The fundamental laws of nature prevent time travel')
    end


end
