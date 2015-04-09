class Task < ActiveRecord::Base
  belongs_to :account
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