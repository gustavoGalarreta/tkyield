class PermitsController < DashboardController
  load_and_authorize_resource
   add_breadcrumb "Dashboard", :dashboard_path
	def index
		#@permission=Permit.create(params[:permission])
	end
end