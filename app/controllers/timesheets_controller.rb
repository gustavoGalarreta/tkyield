class TimesheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_timesheet, only: [:toggle_timesheet]
  add_breadcrumb "Dashboard", :root_path 
  add_breadcrumb "Timesheet", :timesheets_path

  def index
  	@today = Time.zone.now
  	@day_selected = ( params[:date] ) ? Time.parse(params[:date]) : @today 
  	@start_of_week_day = @day_selected.beginning_of_week
    @timesheets = current_user.get_timesheet_per_day @day_selected
    @total_time_today = current_user.obtaining_total_time_per_day @day_selected
    if current_user.projects.any?
      @default_project = current_user.projects.first
      @tasks = @default_project.tasks
    else
      @default_project = nil
      @tasks = []
    end
  end  

  # # GET /timesheets/new
  # def new
  #   @timesheet = Timesheet.new
  #   @timesheet.user = current_user
  # end

  # GET /timesheets/1/edit
  def edit
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

  def toggle_timesheet
    current_user.start_timer @timesheet
    # @timesheets = current_user.get_timesheet_per_day @timesheet.belongs_to_day
    @timesheet.save
    render :json => @timesheet.save, :status => :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_timesheet
    @timesheet = Timesheet.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def timesheet_params
    params.require(:timesheet).permit(:notes,:project_id,:task_id,:user_id,:belongs_to_day)
  end

end

