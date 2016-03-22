class User < ActiveRecord::Base
  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, #:validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  validates :email, :first_name, :last_name, presence: true

  # has_many :prospects

  extend FriendlyId
  friendly_id :first_name, use: [:slugged, :finders]

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_image
    image[0..-7]
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.image = auth.info.image
      user.token = auth.credentials.token
      user.refresh_token = ""
      user.expires_at = auth.credentials.expires_at
      user.expires = auth.credentials.expires
    end
  end

  def self.get_accounts
    where(:team => Team::ACCOUNTS_ID)
  end

  def self.get_php
    where(:team => Team::PHP_TEAM_ID)
  end

  def self.get_rubymobile
    where(:team => Team::RUBY_MOBILE_TEAM_ID)
  end
end
