class Schedule < ActiveRecord::Base
	before_save :default_day
	belongs_to :user
	has_many :events, dependent: :destroy
	scope :is_current, -> {where(current: true)}
	scope :not_set, -> {where(current: false)}
	accepts_nested_attributes_for :events
	def set!
		update(current: true)
	end

	def unset!
		update(current: false)
	end

	def default_day
		self.start = Date.today.to_s
		self.end = (Date.today + 7 ).to_s
	end
end
