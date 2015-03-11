module Reports
  class OnTimeController < ApplicationController
    before_action :authenticate_user!
    add_breadcrumb "Dashboard", :root_path 
    add_breadcrumb "Reports", :reports_list_path 
    
    def index
      add_breadcrumb "On Time Report", :reports_on_time_index_path
      @in_times = TimeStation.where(created_at: @beginning..@end,parent_id: nil).includes(:children)
      @teams = Team.all
      @collaborators = User.all
      respond_to do |format|
        format.html
        format.xlsx
      end
    end

    private

    def set_time
      @today = Time.zone.now.to_date
      @day_selected = ( params[:date] ) ? DateTime.parse(params[:date]) : @today
      @beginning = @day_selected.at_beginning_of_week 
      @end = @day_selected.at_end_of_week
      
    end
  end
end