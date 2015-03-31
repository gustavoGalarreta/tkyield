module Reports
  class ClientsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_time
    before_action :set_client
    add_breadcrumb "Dashboard", :root_path 
    add_breadcrumb "Reports", :reports_list_path 
    add_breadcrumb "Timesheet Report", :reports_dash_path
    def show
      add_breadcrumb "Clients", :reports_client_path
      @projects = Project.between_dates_and_client(@beginning, @end, @client).order("name")
      @users = User.between_dates_and_projects(@beginning, @end, @projects).order("first_name, last_name")
      respond_to do |format|
        format.html
        format.js
      end
    end

    def client_excel
      @timesheets = Timesheet.find_by_dates_and_client(@beginning,@end,@client)
      respond_to do |format|
        format.xlsx
      end
    end

    private 

    def set_client
      @client = Client.find(params[:id] || params[:client_id])
    end

    def set_time
      @today = Time.zone.now.to_date
      @day_selected = ( params[:date] ) ? DateTime.parse(params[:date]) : @today
      puts @day_selected
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