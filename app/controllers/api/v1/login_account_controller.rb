class Api::V1::LoginAccountController < Api::ApiV1Controller
  skip_before_action :validate_account_and_current_user
  
  def create
    @user = User.find_by_email(params[:email])
    
    if @user && @user.valid_password?(params[:password]) && @user.role_id == Role::ADMINISTRATOR_ID
      render template: "api/v1/login_account/create"
    else
      render json: { error: "Email or password is invalid" }, status: :error
    end
  end

end