  class Permit < ActiveRecord::Base
	
	belongs_to :user
  validate :finish_cannot_be_earlier_than_start
	validates :start, presence: true
  validates :finish, presence: true

	private
	    def finish_cannot_be_earlier_than_start
      unless start.nil? || finish.nil?
        time_error if finish.to_time <= start.to_time
      end
    end

    def time_error
      errors.add(:time_error, 'The fundamental laws of nature prevent time travel')
    end

    def self.search(request,start,finish)
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

    def self.accepted_between_dates_and_user beginning, ending, user
      where(user: user, accepted: true).where("start <= ? AND finish >= ?", beginning.beginning_of_day, ending.end_of_day)
    end
end
