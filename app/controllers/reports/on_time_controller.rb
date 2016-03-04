module Reports
  class OnTimeController < DashboardController
    before_action :set_time
    before_action :reporting_options, only: :index
    before_action :set_collaborator, only: :index
    before_action :calendar_options, only: :index
    before_action :filter_time_stations, only: [:index, :daily_excel, :summary_excel]
    add_breadcrumb "Dashboard", :dashboard_path 
    add_breadcrumb "Reports", :reports_list_path 
    
    def index
      add_breadcrumb "On Time Report", :reports_on_time_index_path
      @time_stations_summary = TimeStation.total_in_dates_by_users(@time_stations, @filtered_users)
      @teams = current_account.teams.order("name ASC")
      @collaborators = current_account.users.order("first_name, last_name")
      @month_assistance_record = Permit.get_assitance_record_between_dates_and_user(@selected_collaborator,@date)
    end

    def daily_excel
      respond_to do |format|
        format.xlsx {response.headers['Content-Disposition'] = "attachment; filename='Daily Report.xlsx'"}
      end
    end

    def summary_excel
      @time_stations_summary = TimeStation.total_in_dates_by_users(@time_stations, @filtered_users)
      respond_to do |format|
        format.html
        format.xlsx {response.headers['Content-Disposition'] = "attachment; filename='Summary Report.xlsx'"}
      end
    end

  private
    def set_time
      @tab = (params[:tab]) ? params[:tab] : "tab1"
      @today = Time.zone.now.to_date
      @selected_team = Team.find(params[:team]) unless params[:team].blank?
      @selected_collaborator = User.find(params[:collaborator]) unless params[:collaborator].blank?
      begin
        unless params[:beginning].blank?
          beginning_tmp = Date.strptime(params[:beginning].to_s, "%m/%d/%Y")
          @beginning = Time.zone.local(beginning_tmp.year, beginning_tmp.month, beginning_tmp.day).to_date
        else
          @beginning = @today.at_beginning_of_week
        end
      rescue
        @beginning = @today.at_beginning_of_week
      end
      begin
        unless params[:end].blank?
          end_tmp = Date.strptime(params[:end].to_s, "%m/%d/%Y")
          @end = Time.zone.local(end_tmp.year, end_tmp.month, end_tmp.day).to_date
        else
          @end = @today.at_end_of_week
        end
      rescue
        @end = @today.at_end_of_week
      end
    end

    def filter_time_stations
      @filtered_users = current_account.users.filter(@selected_team, @selected_collaborator)
      @time_stations = TimeStation.between_dates_and_users(@beginning, @end, @filtered_users).includes(:user)
      @time_stations_tmp = @time_stations.group_by{|x| x.created_at.to_date }
    end

    def reporting_options
      @reports = [{"type"=>"Daily"},{"type"=>"Summary"},{"type"=>"Calendar"}]
      @current_report = params[:report]
    end

    def set_collaborator
      @selected = User.find(params[:collaborator]) unless params[:collaborator].blank?
    end
    def calendar_options
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
    end
  end
end