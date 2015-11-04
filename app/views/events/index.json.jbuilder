json.array! @events do |event|
	json.title	event.name
	json.description	event.description
	json.start	event.start.to_s(:iso8601)
	json.end	event.finish.to_s(:iso8601)
	json.url edit_schedule_event_path(event.schedule, event)
end