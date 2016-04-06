class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    auth = request.env["omniauth.auth"]
    email = auth.info.email
    if email.gsub(/.+@([^.]+).+/, '\1') == "tektonlabs"
      @user = User.from_omniauth(auth)

      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    else
      redirect_to root_path
    end
  end

end