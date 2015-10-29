class TkYieldMailer < ApplicationMailer
	default from: "info@tektonlabs.com"
  
  def forgot_checkout(user, time_station)
    @user = user
  	@time_station = time_station
    mail(to: @user.email, subject: "You forgot to check out from #{@user.account_company_name}!")
  end

  def forgot_timer(user)
  	@user = user
  	@timesheet = user.get_timesheet_active.first
  	mail(to: @user.email, subject: "Did you forget your timer?")
  end

  
end
