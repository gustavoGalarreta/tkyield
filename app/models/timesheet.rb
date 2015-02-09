class Timesheet < ActiveRecord::Base

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
		if has_a_timer_running?
			cancel_active_timesheet
		end
		self.running = true
		self.start_time = Time.now
	end

	def stop_timer
		self.running = false
		self.stop_time = Time.now + 1.hours + 3.minutes
		# self.stop_time = Time.now
    	self.total_time += calculate_difference
	end

	def calculate_difference
		self.total_time = (self.stop_time - self.start_time).to_f
  		# puts Time.at(self.total_time).utc.strftime("%H:%M")
   		return self.total_time
	end

	# obtain sum of all the time obtained in one day, maybe just front ? 
	# add current user
	def self.obtaining_total_time_per_day day
		self.get_timesheet_per_day(day).sum(:total_time)
	end

	# query obtaining timesheet per day
	#  add current user
	def self.get_timesheet_per_day day
		self.where(start_time: day.midnight..(day.midnight + 1.day))
	end

	# query obtaining the unique active timesheet
	# add current user	
	def get_timesheet_active
		self.where(running: true).first
	end

	def has_a_timer_running?
		get_timesheet_active != nil
	end

	def cancel_active_timesheet
		get_timesheet_active.stop_timer
	end

end