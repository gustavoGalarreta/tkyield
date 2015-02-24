module ProjectsHelper

	def clients_helper
		Client.all.order("name ASC")
	end

	def tasks_helper
		Task.all.order("name ASC")
	end

	def users_helper
		User.all.order("first_name, last_name ASC")
	end		

end
