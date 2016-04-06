# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  account_id :integer
#

class Team < ActiveRecord::Base
  has_many :collaborators
  validates :name, presence: true
  
  acts_as_paranoid

end
