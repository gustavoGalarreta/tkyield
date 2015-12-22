class Event < ActiveRecord::Base
  belongs_to :schedule
  validate :finish_cannot_be_earlier_than_start
  validates :inTime, presence: true
  validates :outTime, presence: true

  enum day_of_week: [:Mon, :Tue, :Wed, :Thu, :Fri, :Sat, :Sun]

  def day(day)
    where(day_of_week: day)    
  end

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
