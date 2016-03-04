class Schedule < ActiveRecord::Base
	belongs_to :user
	has_many :events, dependent: :destroy
	scope :is_current, -> {where(current: true)}
	scope :not_set, -> {where(current: false)}
	
	def set!
		update(current: true)
	end

	def unset!
		update(current: false)
	end

end
