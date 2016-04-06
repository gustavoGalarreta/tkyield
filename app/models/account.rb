# == Schema Information
#
# Table name: accounts
#
#  id            :integer          not null, primary key
#  subdomain     :string(255)      default(""), not null
#  company_name  :string(255)      default(""), not null
#  company_url   :string(255)      default("")
#  company_phone :string(255)      default("")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Account < ActiveRecord::Base
  has_many :users
  has_many :tasks
  has_many :projects
  has_many :teams

  validates :company_name, presence: true
  validates :company_name, format: { with: /\A[a-zA-Z 0-9]+\z/, message: "only allows letters" }
  validates :company_name, length: { maximum: 200, message: "must be a maximum of 20 characters" }
  validates :subdomain, presence: true, uniqueness: { message: "already exists" }
  validates :subdomain, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :subdomain, length: { in: 3..20, message: "must be a minimum of 3 characters and a maximum of 20 characters" }
  validates :subdomain, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved." }
  validates :company_url, format: { with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z/, message: "only allows URL format" }, allow_blank: true

end
