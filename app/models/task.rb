# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  account_id :integer
#

class Task < ActiveRecord::Base
  has_many :task_projects
  has_many :projects, :through => :task_projects
  has_many :timesheets

  validates :name, presence: true
  
  default_scope {order('name')}
  acts_as_paranoid

  def total_time_per_user_and_project(beginning, ending, user)
    Timesheet.where(belongs_to_day: beginning..ending,user: user, task_id: self.id).sum(:total_time)
  end

  def self.between_dates_and_project(beginning, ending, project)
  	self.select("tasks.*, SUM( timesheets.total_time ) AS total").joins(:timesheets).where("timesheets.belongs_to_day BETWEEN ? AND ?", beginning, ending).where("timesheets.project_id = ?", project.id).group("tasks.id")
  end  	
end
