class ReportsController < ApplicationController
	before_action :authenticate_user!
  	add_breadcrumb "Dashboard", :root_path 
  
  	def index
  		add_breadcrumb "Reports", :reports_path
  	end

	def staff_report
		add_breadcrumb "Staff Report", :reports_report_path
	    @time_stations = TimeStation.all.includes(:user)
	    respond_to do |format|
	      format.html
	      format.xlsx
	    end
	end

	def dash
		@clients = Client.all
		@users = User.all
		@projects = Project.all
	end

end
