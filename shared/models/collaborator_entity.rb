class CollaboratorEntity < ActiveRecord::Base
  self.inheritance_column = nil
  acts_as_paranoid

  belongs_to :collaborator
  belongs_to :entity

  enum type: [:salary, :cts, :pension]

end
