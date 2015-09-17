# == Schema Information
#
# Table name: user_projects
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates_uniqueness_of :project_id, scope: :user_id
end
