module ProjectsHelper
	def projects_helper
		projects = current_user.get_projects.includes(:client)
		grouped_options = projects.inject({}) do |options, project|
			(options[project.client_name] ||= []) << [project.name, project.id]
			options
		end
		return grouped_options
	end

	def projects_count_helper
		current_account.projects.count
	end
end
