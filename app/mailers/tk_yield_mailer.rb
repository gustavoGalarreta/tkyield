class TkYieldMailer < ApplicationMailer
	default from: "mobile@tektonlabs.com"
  
  def forgot_checkout(user)
    @user = user
    mail(to: @user.email, subject: "Did you forgot to check-out from TektonLabs?")
  end

  def forgot_timer(user)
  	@user = user
  	mail(to: [@user.email,"eduardo.arenas@tektonlabs.com"], subject: "Did you forget your timer?")
  end

end
