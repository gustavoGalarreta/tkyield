module Reports
  class ReportsController < ApplicationController
    before_action :authenticate_user!
    add_breadcrumb "Dashboard", :root_path 
    
    def index
      add_breadcrumb "Reports", :reports_list_path
      @clients = Client.all
      @users = User.all
      @projects = Project.all.includes(:client)

      @beginning = Date.today.at_beginning_of_week 
      @end = Date.today.at_end_of_week

    end



  end
end