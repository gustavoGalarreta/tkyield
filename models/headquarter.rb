class Headquarter < ActiveRecord::Base
  belongs_to :country
  has_many :invoices

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :url => Rails.application.config.action_controller.relative_url_root.to_s + "/system/:class/:attachment/:style/:basename.:extension", :path => ":rails_root/public/system/:class/:attachment/:style/:basename.:extension"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def is_peru?
  	Country.find(country.id).name == "Peru"
  end

end
