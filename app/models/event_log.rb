class EventLog < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :user

  def self.last_event(date_to_search)
  	while true
  		unless EventLog.where(date: date_to_search).blank?
  			events = EventLog.where(date: date_to_search)
				break
  		else
  			date_to_search = (date_to_search.to_date - 7).strftime("%Y-%m-%d")
  		end
  	end
  	return events
  end
  
  def set_launch(launch_status)
    if launch_status.nil?
      self.launch = false
    else
      self.launch = true
    end
  end

end
	