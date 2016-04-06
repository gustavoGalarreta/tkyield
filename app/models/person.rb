class Person < ActiveRecord::Base
  has_one :collaborator
  has_many :relationships
  has_many :collaborators, through: :relationships
	 def name
    "#{first_name} #{last_name}"
  end
  alias_method :full_name, :name
end