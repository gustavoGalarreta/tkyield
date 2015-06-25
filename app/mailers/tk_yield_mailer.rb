class TkYieldMailer < ApplicationMailer
	default from: "mobile@tektonlabs.com"
  
  def forgot_email(user)
    @user = user
    mail(to: [@user.email,"eduardo.arenas@tektonlabs.com"], subject: "Did you forgot to check-out from TektonLabs?")
  end
end
