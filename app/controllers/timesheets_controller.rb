class TimesheetsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@today = Time.new
  	@start_of_week_day = @today.beginning_of_week
    @timesheets = current_user.get_timesheet_per_day Time.new
    @total_time_today = current_user.obtaining_total_time_per_day Time.new
  end  

end

