class EventsController<DashboardController
	before_action :set_schedule
	before_action :set_event, only: [:edit, :update]
	
	def new
		@event = Event.new
		@url = schedule_events_path
		@method = 'POST'
	end

	def edit
		@url = schedule_event_path
		@method = 'PUT'
	end

	def update
		@event.update_attributes(event_params)
	end

	def create
		@event = Event.new(event_params)
		@event.schedule = @current
		unless @event.save
			@event.errors.full_messages
		end
	end

	def index
		@events = @current.events
	end

	private

		def event_params
			params.require(:event).permit(:name, :description, :start, :finish, :all_day)			
		end

		def set_schedule
			# @schedule = Schedule.find(params[:id])

			@current = params[:schedule_id] ? current_user.schedules.find(params[:schedule_id]) : current_user.schedules.is_current.first
		end

		def set_event
			@event = Event.find(params[:id])
		end
end