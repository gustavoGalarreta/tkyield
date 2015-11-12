class Event < ActiveRecord::Base
  belongs_to :schedule
  validate :finish_cannot_be_earlier_than_start
  
  validates :inTime,       presence: true
  validates :outTime,      presence: true

  private

    def finish_cannot_be_earlier_than_start
      unless inTime.nil? || outTime.nil?
        time_error if outTime.to_time <= inTime.to_time
      end
    end

    def time_error
      errors.add(:time_error, 'The fundamental laws of nature prevent time travel')
    end
end
