class SchedulesController<DashboardController
	add_breadcrumb "Dashboard", :dashboard_path 
  #before_action :set_event, only: [:edit, :update, :delete, :destroy]
  before_action :set_schedule, only: [:set,:unset, :show]
  before_action :schedule_params, only: [:create]
  respond_to :html, :js, :json


	def index
		add_breadcrumb "Schedules", :schedules_path
		@current_schedule = current_user.schedules.is_current
    @events = current_user.events
    @user=current_user
  end

  def list
    @schedules=current_user.schedules
  end

  def current_schedule
    #Este hardcode hay qe cambiar luego
    @current = current_user.schedules.is_current.first
    @events = @current.events
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

  def show    
  end

  def new
  end

  def create
    s = Schedule.new(schedule_params)
    s.user_id = current_user.id
    s.save
    @schedules=current_user.schedules
  end

  def edit

  end

  def update
    
  end

  def destroy
    @event.destroy 
  end

  private
    def schedule_params
       params.require(:schedule).permit(:name)   
    end

    def set_schedule
      @schedule=Schedule.find(params[:id])
    end
end