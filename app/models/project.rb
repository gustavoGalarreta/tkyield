class Project < ActiveRecord::Base
  belongs_to :account
  belongs_to :client
  has_many :timesheets
  has_many :task_projects, dependent: :nullify
  has_many :tasks, :through => :task_projects
  has_many :user_projects, dependent: :nullify
  has_many :users, :through => :user_projects

  delegate :name, :to => :client, :prefix => true
  after_destroy :stop_timesheets

  validates :account, presence: true
  validates :client, :name, :description, presence: true
  
  accepts_nested_attributes_for :task_projects, :allow_destroy => true, :reject_if => proc { |t| t['task_id'].blank? }
  accepts_nested_attributes_for :user_projects, :allow_destroy => true, :reject_if => proc { |t| t['user_id'].blank? }
  acts_as_paranoid

  def total_time_between_dates(beginning, ending)
    Timesheet.where(project_id: self.id, belongs_to_day: beginning..ending).sum(:total_time)
  end

  def self.between_dates_and_client beginning, ending, client
    projects = self.select("projects.*, SUM( timesheets.total_time ) AS total").joins(:timesheets).where("timesheets.belongs_to_day BETWEEN ? AND ?", beginning, ending).group("projects.id")
    return client.nil? ? projects : projects.where("projects.client_id = ?", client.id)
  end

  def self.between_dates beginning, ending
    self.between_dates_and_client(beginning, ending, nil)
  end

  def total_time_in_users
    Timesheet.total_time_in_users_by_project(self)
  end
  
  def total_time
    Timesheet.where(project_id: self.id).sum(:total_time)
  end

  def total_time_per_task(task, beginning, ending)
    Timesheet.where(belongs_to_day: beginning..ending,project: self, task: task).sum(:total_time)
  end

  def total_time_per_task_and_user(task,beginning, ending, user)
    Timesheet.where(belongs_to_day: beginning..ending,project: self, task: task, user: user).sum(:total_time)
  end

  def stop_timesheets
    timesheets = Timesheet.where(project_id: self.id)
    timesheets.each do |t|
      t.stop_timer
    end
  end
end
