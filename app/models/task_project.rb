class TaskProject < ActiveRecord::Base
	belongs_to :project, dependent: :destroy
	belongs_to :task, dependent: :destroy
end
