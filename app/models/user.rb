class User < ActiveRecord::Base
  has_many :timesheets
  has_many :user_projects
  has_many :projects, :through => :user_projects

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  # This function generates a string joining the admin user's first and last name.
  #
  # * *returns*
  #   - the admin user's full name
  def full_name
    "#{first_name} #{last_name}"
  end
end
