class Timesheet < ActiveRecord::Base
	


	has_one :project
	has_one :task
	has_one :user

	def set_running
		self.status = 1
	end

	def set_stopped
		if(self.total_time != 0){
			
		}
		self.status = 0
	end

	def is_running?
		return self.status == 1
	end

	def start_time 
		if(!is_running?)
			self.start_time = Time.new
			set_running
		end
	end

	def stop_time
		if(is_running?)
			self.stop_time = Time.new
			set_stopped
		end
	end

end
