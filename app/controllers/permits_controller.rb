class PermitsController < DashboardController
  load_and_authorize_resource
   add_breadcrumb "Dashboard", :dashboard_path
   before_action :email_params, only: [:send_email,:permission]
	def index
		add_breadcrumb "Request", :permits_path
		@permits=current_user.permits.order("name ASC")
	end

	def create		
	end

	def send_email
		p '***********************'
		p email_params
		@resources = email_params
		#@user = current_user.get_team_leader
		@user=User.second
		#temporal solo prueba
		#TkYieldMailer.request_mail(@user,email_params,current_user).deliver_later
		redirect_to permits_path
	end

	def permission

	end
	
	private
	def email_params
		params.permit(:description,:start,:end)
	end
end  
