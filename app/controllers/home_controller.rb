# encoding: utf-8
require 'socket'
class HomeController < ApplicationController
  
  def index
  end

  def registration
    @account = Account.new
  end

  def register
    @account = Account.new(account_params)
    @user = User.new(user_params)
    @user.role_id = Role::ADMINISTRATOR_ID
    if @account.save and @user.save and UserAccount.create(account_id: @account.id, user_id: @user.id)
      redirect_to root_path, notice: 'The Account was successfully created. You will receive an email to confirm.'
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
