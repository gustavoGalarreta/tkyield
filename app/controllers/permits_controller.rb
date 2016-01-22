class PermitsController < DashboardController
   load_and_authorize_resource
   add_breadcrumb "Dashboard", :dashboard_path
   before_action :request_options, only: [:index, :permission]
   before_action :permit_params, only: [:new]

	def index
		add_breadcrumb "Request", :permits_path
		@permits = current_user.permits.order("name ASC")
		@permit_filter = current_user.permits.search(params[:request],params[:start],params[:finish])
	end

	def new
	end

	def create	
		p permit_params
	end

	def send_email
		#@resources = email_params
		#@user = current_user.get_team_leader
		#@user=User.second
		#temporal solo prueba
		#TkYieldMailer.request_mail(@user,email_params,current_user).deliver_later
		redirect_to permits_path
	end

	def permission
		add_breadcrumb "Permits", :permits_path
	end
	
	private
		def request_options
			@requests = [{"name"=>"request"},{"name"=>"vacation"},{"name"=>"tardanza justificada"},{"name"=>"descanso medico"}]
		end
		def permit_params
			params.require(:permit).permit(:type_permits, :start, :finish, :description)
		end
end  
