class OperatingSystem < ActiveRecord::Base
  self.inheritance_column = nil

  enum type: [:desktop, :mobile, :wearable, :tv]

  alias_attribute :full_name, :name

  has_many :inventories

end
