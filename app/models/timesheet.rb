class Timesheet < ActiveRecord::Base
	
	belongs_to :project
	belongs_to :task
	belongs_to :user
    
  	def set_total(time)
    	total_time = time
  	end

	def set_running
		self.running = true
		self.start_time = Time.now
	end

	def set_stopped
		self.running = false
		# self.stop_time = Time.now + 1.hours + 3.minutes
		self.stop_time = Time.now
    	self.total_time += calculate_difference
	end

	def is_running?
		return running
	end

	def start_timer
		if(!is_running?)
			set_running
		end
	end

	def stop_timer
		if(is_running?)
			set_stopped
		end
	end

	def calculate_difference
  		self.total_time =  ( (self.stop_time - self.start_time).to_f )/ 3600
	end

	# obtain sum of all the time obtained in one day, maybe just front ? 
	def self.obtaining_total_time_per_day(day)

	end

	# query obtaining timesheet per day
	def self.get_timesheet_per_day(day)
	end
  

end