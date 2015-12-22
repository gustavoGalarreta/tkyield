class EventsController < DashboardController
  #before_action :get_events, only: [:create, :index]

	def index
	end

	def new
	end

	def create
		@schedule = Schedule.find(params[:schedule_id])
		new_event = Event.new(event_params)
		new_event.schedule_id = params[:schedule_id]
		new_event.day_of_week = params[:event][:day_of_week].to_i
		if new_event.errors.blank?
			new_event.save
		end
		@events=Event.all
	end

	def edit
		p '******* edit'
	end

	def update
		p '******* update'
	end

	private

	def event_params
		params.require(:event).permit(:name, :inTime, :outTime)
	end

	def get_events
		@events = Event.all
	end

end