module Reports
  class OnTimeController < ApplicationController
    before_action :authenticate_user!
    add_breadcrumb "Dashboard", :root_path 
    add_breadcrumb "Reports", :reports_list_path 
    
    def index
      add_breadcrumb "On Time Report", :reports_on_time_index_path
      @time_stations = TimeStation.all
      @teams = Team.all
      @collaborators = User.all
      respond_to do |format|
        format.html
        format.xlsx
      end
    end
  end
end