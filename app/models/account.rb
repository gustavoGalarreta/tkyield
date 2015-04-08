class Account < ActiveRecord::Base
  has_many :users

  validates :company_name, presence: true
  validates :company_name, format: { with: /\A[a-zA-Z 0-9]+\z/, message: "only allows letters" }
  validates :company_name, length: { maximum: 200, message: "200 characters maximum" }
  validates :subdomain, presence: true, uniqueness: { message: "The subdomain already exists" }
  validates :subdomain, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :subdomain, length: { in: 3..20, message: "must be a minimum of 3 characters and a maximum of 20 characters" }
  validates :subdomain, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved." }
  validates :company_url, format: { with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z/, message: "only allows URL format" }, allow_blank: true

end
