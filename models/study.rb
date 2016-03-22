class Study < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :entity
  belongs_to :collaborator

  enum type: [:technical, :superior, :posterior, :master, :doctor]
  enum degree: [:unfinished, :finished, :graduate, :bachelor, :certified]

  accepts_nested_attributes_for :entity, reject_if: :all_blank, allow_destroy: true

  belongs_to :collaborator
  belongs_to :entity

end
