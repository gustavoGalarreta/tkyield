module Reports
  class UsersController < ApplicationController
    before_action :authenticate_user!
    add_breadcrumb "Dashboard", :root_path 
    add_breadcrumb "Reports", :reports_list_path 
    
    def show
      @user = User.find params[:id]
      add_breadcrumb "Collaborators", :reports_user_path
      @today = Time.zone.now.to_date
      @day_selected = ( params[:date] ) ? DateTime.parse(params[:date]) : @today
      @beginning = @day_selected.at_beginning_of_week 
      @end = @day_selected.at_end_of_week
      @timesheets = @user.total_time_in_projects_dates(@beginning, @end)
    end
  end
end