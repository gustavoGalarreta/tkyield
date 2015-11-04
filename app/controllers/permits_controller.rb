class PermitsController < DashboardController
  load_and_authorize_resource
   add_breadcrumb "Dashboard", :dashboard_path
   before_action :email_params, only: [:send_email]
	def index
		 add_breadcrumb "Request", :permits_path
	end

	def create		
	end

	def send_email
		 @resources=email_params
		 @user=current_user.get_team_leader
		 TkYieldMailer.request_mail(@user,email_params,current_user).deliver_later
	end

	private
	def email_params
		params.permit(:description,:start,:end)
	end
end