class Entity < ActiveRecord::Base
	self.inheritance_column = nil
  has_one :client
end