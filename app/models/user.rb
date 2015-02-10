class User < ActiveRecord::Base
  has_many :timesheets
  has_many :user_projects
  has_many :projects, :through => :user_projects

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

  # This function generates a string joining the admin user's first and last name.
  #
  # * *returns*
  #   - the admin user's full name
  def full_name
    "#{first_name} #{last_name}"
  end
end
