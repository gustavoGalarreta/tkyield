# == Schema Information
#
# Table name: task_projects
#
#  id         :integer          not null, primary key
#  task_id    :integer
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TaskProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :task

  validates_uniqueness_of :project_id, scope: :task_id
  
  def total_time_between_dates beginning, ending
    Timesheet.where(belongs_to_day: beginning..ending, project_id: self.id).sum(:total_time)
  end

end
