class TimeStation < ActiveRecord::Base
	belongs_to :user
	belongs_to :parent, :class_name => 'TimeStation'
  	has_one :children, :class_name => 'TimeStation', :foreign_key => 'parent_id'
	acts_as_xlsx
	
	def working?
    	self.working
	end

	def define_in_time		
	    self.working = true
	    self.in_time = Time.zone.now
	    self.save
	end

	def define_out_time
	    self.working = false
	    self.out_time = Time.zone.now
	    self.total_time += calculate_difference
	    self.save
  	end

  	
end
