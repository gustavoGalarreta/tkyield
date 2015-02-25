class Project < ActiveRecord::Base
  belongs_to :client
  has_many :timesheets
  has_many :task_projects, dependent: :destroy
  has_many :tasks, :through => :task_projects
  has_many :user_projects, dependent: :destroy
  has_many :users, :through => :user_projects 

  validates :client, :name, :description, presence: true

  accepts_nested_attributes_for :task_projects, :allow_destroy => true, :reject_if => proc { |t| t['task_id'].blank? }
  accepts_nested_attributes_for :user_projects, :allow_destroy => true, :reject_if => proc { |t| t['user_id'].blank? }
end
