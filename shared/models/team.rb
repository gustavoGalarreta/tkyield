class Team < ActiveRecord::Base
  acts_as_paranoid

  has_many :inventories
  has_many :collaborators
  has_many :prospects

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

end
