module TimesheetsHelper

	def projects_helper
		projects = current_user.projects.order("name ASC")
		grouped_options = projects.inject({}) do |options, project|
			(options[project.client.name] ||= []) << [project.name, project.id]
			options
		end
		return grouped_options
	end

	def new_timesheet
		Timesheet.new
	end

	def date_format_on_view(date)
		date.strftime("%Y-%m-%d")
	end

end
