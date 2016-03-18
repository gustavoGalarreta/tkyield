class Permit < ActiveRecord::Base
  belongs_to :user
  belongs_to :receptor, :foreign_key => :receptor_id, :class_name => "User"

  validate :finish_cannot_be_earlier_than_start
  validates :start, presence: true
  validates :finish, presence: true

  enum status: [:rejected, :accepted, :pending]
  enum type_permit: [:vacation, :medical_rest, :excused_delay, :days_off]

  after_create :send_permit_mail

  def send_request(params, date=nil)
    begin
      self.type_permit = params[:type_permit].to_sym
      self.description = params[:description]
      if self.excused_delay?
        unless date.blank?
          self.start = Date.strptime(date.to_s, "%m/%d/%Y")
          self.finish = Date.strptime(date.to_s, "%m/%d/%Y")
        end
      else
        self.start = Date.strptime(params[:start].to_s, "%m/%d/%Y") unless params[:start].blank?
        self.finish = Date.strptime(params[:finish].to_s, "%m/%d/%Y") unless params[:finish].blank?
      end
      unless self.user.team_leader?
        self.receptor_id = self.user.get_team_leader.id if self.user.get_team_leader
      end
      return self.save
    rescue Exception => e
      self.errors.add(:base, e)
      return false
    end
  end

  def self.accepted_between_dates_and_user beginning, ending, user
    self.accepted.where(user: user).where("start >= ? AND finish <= ?", beginning.beginning_of_day, ending.end_of_day)
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
    permits = request.present? ? where(type_permit: self.type_permits[request.to_sym]) : all
    permits = permits.where(["start >= ?", Date.strptime(start, "%m/%d/%Y").to_datetime.beginning_of_day]) if start.present?
    permits = permits.where(["finish <= ?", Date.strptime(finish, "%m/%d/%Y").to_datetime.end_of_day]) if finish.present?
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
