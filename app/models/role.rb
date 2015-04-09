class Role < ActiveRecord::Base
  has_many :users , dependent: :nullify

  default_scope {order('name')}
  
  MANAGER_ID = 1
  COLLABORATOR_ID = 2
  ADMINISTRATOR_ID = 3

  def self.manager
    find(MANAGER_ID)
  end
  
  def self.collaborator
    find(COLLABORATOR_ID)
  end
  
  def self.administrator
    find(ADMINISTRATOR_ID)
  end

end
