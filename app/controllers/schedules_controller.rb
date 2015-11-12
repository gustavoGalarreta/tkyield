class SchedulesController<DashboardController
	add_breadcrumb "Dashboard", :dashboard_path 
	before_action :set_schedule, only: [:show,:set,:unset, :destroy]
	before_action :get_current_schedule, only: [:create_schedule,:current_schedule,:edit]


	def index
		add_breadcrumb "Schedules", :schedules_path
		@schedules = current_user.schedules
	end

	def show
	end

	def new		
	end

	def set
		@current_schedule = current_user.schedules.is_current.first
    @current_schedule.unset! if @current_schedule
    unless @schedule.set!
      render js: "alert('An error has ocurred')"
    end
	end

	def unset
		@current_schedule = current_user.schedules.is_current.first
    unless @schedule.unset!
      render js: "alert('An error has ocurred')"
    else
      render :set
    end
	end

	def edit
		@schedule = Schedule.find(params[:id])
	end

	def destroy
		@schedule.destroy
		@schedules = current_user.schedules
	end

	def create
		p'Entra create'
		s=Schedule.new(schedule_params)
	  s.user_id = current_user.id

		s.save
		@schedules = current_user.schedules
	end

	def current_schedule
		add_breadcrumb "Schedules", :current_schedule_schedules_path
		7.times do |index|
			@schedule.events.build(day_of_week: index)
		end  
	end

	def create_schedule
		@schedule = Schedule.find(params[:id])
		@schedule.update_attributes(schedule_params_without_name)
	end
	private
		def schedule_params_without_name
      params.require(:schedule).permit(events_attributes:[:id, :inTime,:outTime,:day_of_week])
    end

    def schedule_params
      params.require(:schedule).permit(:name, events_attributes:[:id, :inTime,:outTime,:day_of_week])
    end

    def set_schedule
    	@schedule = Schedule.find(params[:id])
    end
    
    def get_current_schedule
    	@schedule=current_user.schedules.find_by(current: true )
    end
end