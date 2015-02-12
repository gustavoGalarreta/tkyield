module ApplicationHelper

	def get_seconds_in_hours_minutes time
		Time.at(time).utc.strftime("%H:%M")
	end

	def get_date_in_day_format date
		date.strftime("%A")
	end
end
