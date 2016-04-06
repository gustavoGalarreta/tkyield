class SchedulesController<DashboardController
	add_breadcrumb "Dashboard", :dashboard_path
  before_action :set_schedule, only: [:set, :destroy, :edit, :update]
  before_action :get_schedules, only: [:index, :set, :destroy, :create]
  before_action :get_events, only: [:create, :edit, :index]
  before_action :set_collaborator, only: [:index, :create, :set]
  def index
  end

  def create
    s = Schedule.new(schedule_params)
    s.collaborator_id = @collaborator.id
    if s.errors.blank? 
      s.save
    end
  end

  def set
    @collaborator.current_schedule.unset! unless @collaborator.current_schedule.blank?
    @schedule.set!
  end

  def edit
    @events_duration_array = Event.events_duration_array(@schedule.events)
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

    def set_collaborator
      @collaborator = Collaborator.where(code: current_user.pin_code).first
    end
end