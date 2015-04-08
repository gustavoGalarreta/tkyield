# encoding: utf-8
class DashboardController < ApplicationController
  before_action :authenticate_user!
end
