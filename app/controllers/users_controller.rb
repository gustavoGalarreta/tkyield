class UsersController < DashboardController
  load_and_authorize_resource
  add_breadcrumb "Dashboard", :dashboard_path
  add_breadcrumb "Collaborators", :users_path
  before_action :set_user, only: [:resend_confirmation, :archive_user, :schedule]
  respond_to :html, :js, :json

  def index
    @teams = Team.all
    #@users_without_team = current_account.users.active.without_team.includes(:role).order("first_name, last_name")
  end

  def archives
    add_breadcrumb "Archives", :archives_users_path
    @teams = current_account.teams.order("name")
    @users_without_team = current_account.users.archived.without_team.includes(:role).order("first_name, last_name")
  end

  def archive
    @success = @user.archive! ? true : false
  end

  def unarchive
    @success = @user.unarchive! ? true : false
  end 

  def new
    @user = User.new
  end

  def resend_confirmation
    @user.send_confirmation_instructions
    redirect_to users_path, notice: "Email sent successfully"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_account.users.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:avatar, :first_name, :last_name, :role_id, :team_id, :email, :archived_at, :team_leader)
    end

    def user_project_params
      params.require(:user).permit(user_projects_attributes: [:id, :project_id, :_destroy])
    end
end