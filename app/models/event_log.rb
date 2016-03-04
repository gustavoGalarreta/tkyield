class EventLog < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :user

  def self.last_event date_to_search
    hash_event = EventLog.all.group_by{|event| event.date }
    while true
      unless hash_event[date_to_search].nil?
        break
      end
      date_to_search =  ( date_to_search.to_date - 7 ).strftime("%Y-%m-%d")
    end
    return hash_event[date_to_search]
  end
  
  def set_launch(launch_status)
    if launch_status.nil?
      self.launch = false
    else
      self.launch = true
    end
  end
  def set_event_data inTime, outTime, schedule_id, user_id, date, launch_status
    self.inTime = inTime
    self.outTime = outTime
    self.schedule_id = schedule_id
    self.user_id = user_id
    self.edited = true
    self.date = date
    self.set_launch(launch_status)
    self.save
  end
end
	