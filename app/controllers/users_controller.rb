class UsersController < ApplicationController
    load_and_authorize_resource
	before_action :authenticate_user!
	add_breadcrumb "Dashboard", :root_path 
	add_breadcrumb "Employees", :users_path

	def index
   	@users = User.all
  end

  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    add_breadcrumb "Edit", :edit_user_path
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :role_id, :email)
  end
end