module ClientsHelper
	def clients_helper
		current_account.clients.order("name ASC")
	end
end
