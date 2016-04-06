class Schedule < ActiveRecord::Base
	belongs_to :collaborator
	has_many :events, dependent: :destroy
	has_many :event_logs, dependent: :destroy
	scope :is_current, -> {where(current: true)}
	scope :not_set, -> {where(current: false)}
	
	def set!
		update(current: true)
	end

	def unset!
		update(current: false)
	end

end
