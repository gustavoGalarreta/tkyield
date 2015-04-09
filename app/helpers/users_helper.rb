module UsersHelper
	def users_helper
		current_account.users.order("first_name, last_name ASC")
	end

	def teams_helper
		current_account.teams.order("name ASC")
	end

	def roles_helper
		Role.where("id in (?)",[Role::COLLABORATOR_ID, Role::MANAGER_ID])
	end
end
