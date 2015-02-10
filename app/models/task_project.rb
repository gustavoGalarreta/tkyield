class TaskProject < ActiveRecord::Base
	validates :project, :task , presence: true
	belongs_to :project
	belongs_to :task
end
