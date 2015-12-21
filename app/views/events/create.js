$("#new-event").modal('hide');
$("#event-row").html('<%= escape_javascript render partial: "schedules/event_row", locals: {events: @events}%>')
