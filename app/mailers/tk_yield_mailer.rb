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

  def request_mail(permit)
    @permit = permit
    @controller_name = "#{permit.class.name.pluralize.downcase}"
    @receptor_rrh = ENV['email_rrhh'] 
    #posteriormente cambiar a los destinatarios correctos
    #@permit_receptor = User.find(permit.receptor)
    #@receptor_rrhh
    mail( :to => ["gustavo.galarreta@tektonlabs.com","gustavo.galarreta@pucp.pe"],:subject => 'Resquest for permission' )
  end
  
end
