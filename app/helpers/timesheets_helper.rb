module TimesheetsHelper

	def projects_helper
		# current_user.projects
		Project.all
	end

	def new_timesheet
		Timesheet.new
	end

end
