class ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_project, only: [:tasks, :show, :edit, :update, :destroy]
  add_breadcrumb "Dashboard", :root_path 
  add_breadcrumb "Projects", :projects_path

  # GET /projects
  # GET /projects.json
  def index
    @clients = Client.order("name ASC").all
    @projects = Project.order("name ASC").all
  end

  # GET /project_tasks.js
  def tasks
    @timesheetId = params["timesheetId"].nil? ? nil : params["timesheetId"]
    @tasks = @project.tasks.order("name ASC").all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.users << current_user
    @project.task_projects.build
    @project.user_projects.build
  end

  # GET /projects/1/edit
  def edit
    add_breadcrumb "Edit", :edit_project_path
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :client_id, :description, task_projects_attributes: [:id, :task_id, :_destroy], user_projects_attributes: [:id, :user_id, :_destroy])
    end
end
