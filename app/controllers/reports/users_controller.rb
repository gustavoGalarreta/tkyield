module Reports
  class UsersController < DashboardController
    before_action :set_time
    before_action :set_user
    add_breadcrumb "Dashboard", :dashboard_path 
    add_breadcrumb "Reports", :reports_list_path 
    add_breadcrumb "Timesheet Report", :reports_dash_path

    def show
      add_breadcrumb "Collaborators", :reports_user_path
      timesheets = Timesheet.includes(:user).where(belongs_to_day: @beginning..@end,user: @user)
      @project_times = timesheets.includes(:project).group(:project_id).order("belongs_to_day ASC")
      @task_times = timesheets.includes(:task).group(:task_id).order("belongs_to_day ASC")
      respond_to do |format|
        format.html
        format.js
      end
    end
    def user_excel
      @timesheets = Timesheet.find_by_dates_and_user(@beginning,@end,@user)
      respond_to do |format|
        format.xlsx
      end
    end
    private 
    def set_user
      @user = User.find(params[:id]|| params[:user_id])
    end
    def set_time
      @today = Time.zone.now.to_date
      @day_selected = ( params[:date] ) ? DateTime.parse(params[:date]) : @today
      @type = (params[:type]) ? params[:type] : "Weekly"
      @tab = (params[:tab]) ? params[:tab] : "tab1"
      if @type == "Weekly"
        @beginning = @day_selected.at_beginning_of_week 
        @end = @day_selected.at_end_of_week
      elsif @type == "Monthly"
        @beginning = @day_selected.at_beginning_of_month
        @end = @day_selected.at_end_of_month
      end
    end
  end
end