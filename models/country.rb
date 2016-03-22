class Country < ActiveRecord::Base
  has_many :entities
  has_many :headquarters

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def get_abrev
    if id == 173
      "PE"
    elsif id == 232
      "USA"
    elsif id == 142 
      "MEX"
    end

  end
end