# encoding: utf-8
class DashboardController < ApplicationController
  before_action :authenticate_user!

  # def authenticate_user!
  #   super
  #   if current_account != current_user.account
  #     sign_out_and_redirect(current_user)
  #   end
  # end

end