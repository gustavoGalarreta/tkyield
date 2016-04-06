class Quotation < ActiveRecord::Base
  belongs_to :prospect
  has_many :quotation_estimations, :dependent => :destroy
  has_many :estimations, through: :quotation_estimations
  belongs_to :currency

  accepts_nested_attributes_for :quotation_estimations
  accepts_nested_attributes_for :estimations

  validates :quotation_estimations, :length => {:minimum => 1}

end
