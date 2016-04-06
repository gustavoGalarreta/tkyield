class Relationship < ActiveRecord::Base
  self.inheritance_column = nil

	belongs_to :collaborator
  belongs_to :person

end