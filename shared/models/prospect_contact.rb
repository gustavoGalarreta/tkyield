class ProspectContact < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :prospect
  belongs_to :contact
end
