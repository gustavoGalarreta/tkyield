class TimeStation < ActiveRecord::Base
	belongs_to :user
	acts_as_xlsx
	
end
