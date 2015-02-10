class Project < ActiveRecord::Base
	validates :client, :name, :description, presence: true

	belongs_to :client
	has_many :task_projects, dependent: :destroy
	has_many :tasks, :through => :task_projects
	has_many :user_projects
	has_many :users, :through => :user_projects 
	has_many :timesheets

	accepts_nested_attributes_for :task_projects
	accepts_nested_attributes_for :tasks
end
