class UserDevice::SessionsController < Devise::SessionsController
  after_filter :set, :only => :create
  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    if !self.resource.nil? and self.resource.account == current_account
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    respond_to_on_destroy
  end

  def set

    if current_user.schedules.empty?
      p "Entro :D"
      current_user.set_first_schedule
    end
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me, :account_id) }
    end

end
