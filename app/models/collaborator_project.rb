class CollaboratorProject < ActiveRecord::Base
	belongs_to :collaborator
  belongs_to :project

  #validates_uniqueness_of :project_id, scope: :user_id
end