# encoding: utf-8
class HomeController < ApplicationController
  layout 'home'

  def index
  end

  def registration
    @account = Account.new
  end

  def register
    @account = Account.new(account_params)
    if @account.save
      @user = User.new(user_params)
      @user.role_id = Role::ADMINISTRATOR_ID
      @user.account_id = @account.id
      @user.save
      redirect_to root_url(subdomain: false), notice: 'The Account was successfully created. You will receive an email to confirm.'
    else
      render :registration
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:company_name, :subdomain, :company_url, :company_phone)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
    
end
