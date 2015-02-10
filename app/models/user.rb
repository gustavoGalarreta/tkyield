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

  def start_timer timesheet
    if has_a_timer_running?
      cancel_active_timesheet
    end
    timesheet.toggle_timer
  end

  def stop_timer timesheet
    timesheet.toggle_timer
  end

  def obtaining_total_time_per_day day
    get_timesheet_per_day(day).sum(:total_time)
  end

  def get_timesheet_per_day day
    Timesheet.where(created_at: day.midnight..(day.midnight + 1.day), user_id: self.id)
  end

  def get_timesheet_active
    Timesheet.where(running: true, user_id: self.id).first
  end

  def has_a_timer_running?
    get_timesheet_active != nil
  end

  def cancel_active_timesheet
    stop_timer get_timesheet_active
  end


end
