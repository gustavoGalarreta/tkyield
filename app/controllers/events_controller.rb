class EventsController < DashboardController
	before_action :get_schedule, only: [:create, :update, :destroy]
	before_action :get_events, only: :create
	def index
	end

	def new
	end

	def create
		#Event_log------------> improve the code---> pending
		event_log = EventLog.new
		event_log.inTime = event_params[:inTime]
		event_log.outTime = event_params[:outTime]
		event_log.schedule_id = params[:schedule_id]
		event_log.user_id = current_user.id
		event_log.edited = true
		event_log.date = Chronic.parse('monday', :context => :past).to_date  + params[:event][:day_of_week].to_i
		event_log.set_launch(params[:event][:launch])
		event_log.save
		new_event = Event.new(event_params)
		new_event.schedule_id = params[:schedule_id]
		new_event.day_of_week = params[:event][:day_of_week].to_i
		new_event.last_event_log = event_log.id
		if new_event.errors.blank?
			new_event.save
		end
	end

	def edit
	end

	def update
		@current_event = Event.find(params[:id])
		#Event_log------------> improve the code---> pending
		last_event_log = EventLog.find(@current_event.last_event_log)
		last_event_log.edited = false
		last_event_log.save
		event_log = EventLog.new
		event_log.inTime = params[:start_event]
		event_log.outTime = params[:finish_event]
		event_log.schedule_id = params[:schedule_id]
		event_log.user_id = current_user.id
		#event_log.set_launch(params[:event][:launch])
		event_log.launch = false
		event_log.edited = true
		last_day = @current_event.day_of_week.to_date.wday
		event_log.date = Chronic.parse('monday', :context => :past).to_date + last_day - 1
		event_log.save		
		@current_event.update_attributes({:name=>params[:name_event], :inTime=>params[:start_event], :outTime=>params[:finish_event], :last_event_log=>event_log.id})
	end

	def destroy
		p params[:id]
		#@current_event = Event.find(params[:id])
		#p @current_event
	end

	private

	def event_params
		params.require(:event).permit(:name, :inTime, :outTime)
	end

	def get_events
		@events = Event.all
	end

	def get_schedule
		@schedule = Schedule.find(params[:schedule_id])	
		
	end
end