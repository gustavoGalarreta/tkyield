class Relationship < ActiveRecord::Base
  self.inheritance_column = nil

  enum type: [:relative, :spouse, :children, :parental, :friend]

  belongs_to :collaborator
  belongs_to :person

  accepts_nested_attributes_for :person, reject_if: :all_blank, allow_destroy: true

end
