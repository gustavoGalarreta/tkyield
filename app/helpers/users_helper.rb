module UsersHelper
	def users_helper
		current_account.users.order("first_name, last_name ASC")
	end

	def teams_helper
		current_account.teams.order("name ASC")
	end
end
