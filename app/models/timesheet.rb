class Timesheet < ActiveRecord::Base
  validates :project, :task, :user, presence: true
  belongs_to :project
  belongs_to :task
  belongs_to :user

  def set_total(time)
    total_time = time
  end

  def toggle_timer
    is_running? ? stop_timer : start_timer
  end

  def is_running?
    self.running
  end

  def start_timer
    self.running = true
    self.start_time = Time.now
  end

  def stop_timer
    self.running = false
    #self.stop_time = Time.now + 1.hours + 3.minutes
    self.stop_time = Time.now
    self.total_time += calculate_difference
  end

  def calculate_difference
    self.total_time = (self.stop_time - self.start_time).to_f
    # puts Time.at(self.total_time).utc.strftime("%H:%M")
    return self.total_time
  end

end
