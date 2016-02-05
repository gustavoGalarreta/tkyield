class Event < ActiveRecord::Base
  belongs_to :schedule
  validate :finish_cannot_be_earlier_than_start
  validates :inTime, presence: true
  validates :outTime, presence: true

  enum day_of_week: [:Mon, :Tue, :Wed, :Thu, :Fri, :Sat, :Sun]

  def day(day)
    where(day_of_week: day)    
  end
  def belongs_at_this_time(hour)
    current_hour = (7+hour)*60
    start = self.inTime.to_time.strftime("%H:%M").split(':')
    start = (start[0].to_i)*60 + (start[1].to_i)
    finish = self.outTime.to_time.strftime("%H:%M").split(':')
    finish = (finish[0].to_i)*60 + (finish[1].to_i)
    return (current_hour >= start) && (current_hour < finish)
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
