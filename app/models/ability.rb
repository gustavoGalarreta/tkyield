class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_administrator? or user.is_manager?
        can :manage, :all
    elsif user.is_employee?
        can :manage, Timesheet
    end
  end

end
