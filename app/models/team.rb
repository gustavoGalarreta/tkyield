class Team < ActiveRecord::Base
  belongs_to :account
  has_many :users , dependent: :nullify
  
  validates :name, presence: true
  acts_as_paranoid

end
