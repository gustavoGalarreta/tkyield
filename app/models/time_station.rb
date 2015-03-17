class TimeStation < ActiveRecord::Base
	belongs_to :user
	belongs_to :parent, :class_name => 'TimeStation'
  	has_one :children, :class_name => 'TimeStation', :foreign_key => 'parent_id'
	acts_as_xlsx

	def total_per_day_between_dates( beginning, ending)
		i =  (ending - beginning).to_i
		total_per_day = []
		(0..i).each{ |index| total_per_day << TimeStation.where(created_at: beginning+index.days..beginning+index.days).sum(:total_time) }
		return total_per_day
	end
  	
end
