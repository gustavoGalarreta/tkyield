# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer
#

class Client < ActiveRecord::Base
  self.inheritance_column = nil
  belongs_to :entity
  has_many :projects
  delegate :name, :corporate_name, :address, :phone, :legal_id, :country, :country_name, to: :entity, allow_nil: true
  
  validates_associated :entity

  def total_time_between_dates(beginning, ending)
    Timesheet.joins(project: :client).where(projects: {client_id: self.id}, belongs_to_day: beginning..ending).sum(:total_time)
  end

  def self.between_dates beginning, ending
    self.select("clients.*, SUM( timesheets.total_time ) AS total").joins(projects: :timesheets).where("timesheets.belongs_to_day BETWEEN ? AND ?", beginning, ending).group("projects.client_id")
  end

  def total_time
    Timesheet.joins(project: :client).where(projects: {client_id: self.id}).sum(:total_time)
  end

  

end
