class Task < ActiveRecord::Base
	has_many :task_projects
	has_many :timesheets
	
end
