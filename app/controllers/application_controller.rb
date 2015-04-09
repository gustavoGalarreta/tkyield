class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :validate_account_and_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_account

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to dashboard_path, :alert => exception.message
    else
      # redirect_to root_url(subdomain: false)
      redirect_to root_url
    end
  end

  def validate_account_and_current_user
    if current_user and current_account != current_user.account
      sign_out_and_redirect(current_user)
    end
  end

  def current_account
    # @current_account ||= Account.find_by(subdomain: request.subdomain)
    @current_account ||= Account.find_by(subdomain: params[:route])
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:avatar, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:avatar,:first_name, :last_name, :email, :password, :password_confirmation, :current_password) }
    end

end