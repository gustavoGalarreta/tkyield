class SchedulesController<DashboardController
	add_breadcrumb "Dashboard", :dashboard_path
  before_action :set_schedule, only: [:set, :destroy, :edit]
  before_action :get_schedules, only: [:index, :set, :destroy, :create]
  before_action :get_events, only: [:create, :edit, :index]

  def index
  end

  def create
    s = Schedule.new(schedule_params)
    s.user_id = current_user.id
    if s.errors.blank? 
      s.save
    end
  end

  def set
    current_user.current_schedule.first.unset! unless current_user.current_schedule.blank?
    @schedule.set!
  end

  def edit
  end

  def update
  end

  def destroy
    @schedule.destroy
  end

  private
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def get_schedules
      @schedules = Schedule.all
    end

    def schedule_params
      params.require(:schedule).permit(:user_id, :name)
    end

    def get_events
      @events = Event.all
    end

end