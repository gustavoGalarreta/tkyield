class TimesheetsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@today = Time.new
    p "ME LLAMO DE NUEVO"
  	@day_selected = ( params[:date] ) ? Time.parse(params[:date]) : @today 
  	@start_of_week_day = @day_selected.beginning_of_week
    @timesheets = current_user.get_timesheet_per_day @day_selected
    @total_time_today = current_user.obtaining_total_time_per_day @day_selected
    @default_project = Project.all.first # current_user.projects.first
    @tasks = @default_project.tasks
  end  

  # # GET /timesheets/new
  # def new
  #   @timesheet = Timesheet.new
  #   @timesheet.user = current_user
  # end

  # GET /timesheets/1/edit
  def edit
  end

  def show
    @roject = Project.find_by("id = ?", params[:project_id])
  end

  # POST /timesheets
  # POST /timesheets.json
  def create
    @timesheet = Timesheet.new(timesheet_params)
    @timesheet.user = current_user
    @timesheet.inspect    
    @timesheets = current_user.get_timesheet_per_day @timesheet.belongs_to_day
    current_user.start_timer(@timesheet)
    @timesheet.save
  end

  def toogle_timesheet
    p "PARAMS #{params}"
    
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_timesheet
    @timesheet = Client.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def timesheet_params
    params.require(:timesheet).permit(:notes,:project_id,:task_id,:user_id,:belongs_to_day)
  end

end

