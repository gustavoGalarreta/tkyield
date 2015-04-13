module Reports
  class UserProjectController < DashboardController
    before_action :set_time
    add_breadcrumb "Dashboard", :dashboard_path 
    add_breadcrumb "Reports", :reports_list_path 
    add_breadcrumb "Timesheet Report", :reports_dash_path
    
    
    def show
      add_breadcrumb "Collaborator - Project", :reports_user_project_path
      @user = User.find params[:user_id]
      @project = Project.find params[:project_id]
      @timesheets = Timesheet.where(belongs_to_day: @beginning..@end,user_id: @user.id, project_id: @project.id).includes(:task)
      @total = @timesheets.inject(0){|sum,e| sum += e.total_time }
      respond_to do |format|
        format.html
        format.js
        format.xlsx {response.headers['Content-Disposition'] = "attachment; filename='User #{@user.full_name} on Project #{@project.name} Report.xlsx'"}
      end
    end

    private

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