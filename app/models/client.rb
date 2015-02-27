class Client < ActiveRecord::Base
  has_many :projects

  validates :name, presence: true
  acts_as_xlsx

  def client_total_time 
  	  	Timesheet.joins(project: :client).where(projects: {client_id: self.id}).sum(:total_time)
  end

end
