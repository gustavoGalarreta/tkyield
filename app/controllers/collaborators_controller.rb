class CollaboratorsController < DashboardController
  load_and_authorize_resource
  add_breadcrumb "Dashboard", :dashboard_path
  add_breadcrumb "Collaborators", :collaborators_path
	before_action :set_collaborator, only: [:archive, :unarchive]
  before_action :set_teams, only: [:index, :edit, :update]	

  def new
  end

  def create
  end

  def index
  end
  
  def edit
    add_breadcrumb "Edit", :edit_collaborator_path
  end

  def update
    respond_to do |format|
      if @collaborator.update_collaborator(collaborator_params)
        format.html { redirect_to collaborators_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @success = @collaborator.archive! ? true : false
    
  end
  def unarchive
    @success = @collaborator.unarchive! ? true : false
  end

  def projects
    add_breadcrumb "Assign Projects", :show_collaborator_project_collaborator_path
    @projects = @collaborator.projects
    @grouped_options = @projects.inject({}) do |options, project|
      (options[project.client_name] ||= []) << [project.name, project.id]
      options
    end
  end

  def schedule
    add_breadcrumb "#{@collaborator.first_name}'s schedule", :schedule_collaborator_path
    @schedule = @collaborator.schedules.is_current.first
  end

  #pendiente
  def update_projects
    respond_to do |format|
      if @collaborator.update(collaborator_project_params)
        format.html { redirect_to show_collaborator_project_collaborator_path(@collaborator), notice: 'Projects assigned successfully.' }
      else
        format.html { redirect_to show_collaborator_project_collaborator_path(@collaborator), alert: 'Duplicate assigned project(s)' }
      end
    end
  end
  
  private
    def set_collaborator
      @collaborator = Collaborator.where(code: current_user.pin_code).first
    end

    def set_teams
      @teams = Team.all
    end

    def collaborator_params
      #avatar,:role_id, :archived_at, :team_leader
      params.require(:collaborator).permit(:first_name, :last_name, :work_mail, :team_id)
    end

    def collaborator_project_params
      params.require(:collaborator).permit(collaborator_projects_attributes: [:id, :project_id, :_destroy])
    end
end