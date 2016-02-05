class PermitsController < DashboardController
   load_and_authorize_resource
   add_breadcrumb "Dashboard", :dashboard_path
   before_action :request_options, only: [:index, :permission]
   before_action :set_start_and_finish_dates, only: [:create]
   before_action :set_permit, only: [:accept, :decline]

	def index
		add_breadcrumb "Request", :permits_path
		@permits = current_user.permits.order("name ASC").paginate(:page => params[:page], :per_page => 10) 
		@permit_filter = current_user.permits.search(params[:request],@start,@finish).paginate(:page => params[:page], :per_page => 10) 
	end

	def new
	end

	def create
		permit = current_user.permits.new(permit_params)
		permit.assign_attributes(status: 2, start: @start, finish: @finish)
		unless current_user.team_leader?
		 	permit.receptor_id = current_user.get_team_leader.id
		end 
		if permit.save
			redirect_to permits_path
		else
			render js: "alert('not saved')"
		end
	end

	def accept
		if (@permit.status == 2)
			@permit.status = 1
			@permit.save
			flash[:success] = "the request was sent correctly"
		else
			flash[:error] = "the request wasn't sent correctly"
		end
		redirect_to permits_path
	end

	def decline
		if (@permit.status == 2)
			@permit.status = 0
			@permit.save
			flash[:notice] = "the request has been rejected"
		else
			flash[:notice] = "the request hasn't been rejected"
		end
		redirect_to permits_path
	end


	def permission
		add_breadcrumb "Permits", :permits_path
	end
	
	private
		def request_options
			@requests = [{"name"=>"vacation"},{"name"=>"medical rest"},{"name"=>"excused delay"}]
		end
		def permit_params
			params.require(:permit).permit(:type_permits, :start, :finish, :description)
		end
		def set_start_and_finish_dates
      if params[:permit][:type_permits] == "excused delay"
        @start = @finish = Date.strptime(params[:permit][:date].to_s, "%m/%d/%Y")
      else
	      @start = Date.strptime(params[:permit][:start].to_s, "%m/%d/%Y")
	      @finish = Date.strptime(params[:permit][:finish].to_s, "%m/%d/%Y")
      end
    end

    def set_permit
    	@permit = Permit.find(params[:permit_id])
    end

end  
