module Reports
  class UsersController < ApplicationController
    before_action :authenticate_user!
    add_breadcrumb "Dashboard", :root_path 
    add_breadcrumb "Reports", :reports_list_path 
    
    def show
      @user = User.find params[:id]
      add_breadcrumb @user.full_name, :reports_user_path
      @timesheets = @user.timesheets.includes(:project)
    end
  end
end