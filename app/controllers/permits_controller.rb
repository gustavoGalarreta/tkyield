class PermitsController < DashboardController
  load_and_authorize_resource
  before_action :request_options, only: [:index, :permission, :create]
  before_action :set_permit, only: [:accept, :decline]
  add_breadcrumb "Dashboard", :dashboard_path
  add_breadcrumb "Requests", :permits_path

  def index
    @permits = current_user.permits.order("name ASC").paginate(:page => params[:page], :per_page => 10)
    @permit_filter = current_user.permits.search(params[:request], params[:start], params[:finish]).paginate(:page => params[:page], :per_page => 10)
  end

  def new
  end

  def create
    @permit = current_user.permits.pending.new
    if @permit.send_request(permit_params, params[:permit][:date])
      redirect_to permits_path
    else
      flash[:alert] = get_errors(@permit)
      render action: :permission
    end
  end

  def accept
    if @permit.pending?
      @permit.accepted!
      flash[:success] = "The request has been ACCEPTED."
    else
      flash[:error] = "The request could not be accepted."
    end
    redirect_to permits_path
  end

  def decline
    if @permit.pending?
      @permit.rejected!
      flash[:notice] = "The request has been REJECTED."
    else
      flash[:error] = "The request could not be rejected."
    end
    redirect_to permits_path
  end


  def permission
    add_breadcrumb "Permission", :permission_permits_path
    @permit = Permit.new
  end

  private

  def request_options
    @requests = Permit.type_permits.map{|k, v| [k.gsub("_", " ").titleize, k]}
  end

  def permit_params
    params.require(:permit).permit(:type_permit, :start, :finish, :description)
  end

  def set_permit
    @permit = Permit.find(params[:permit_id])
  end

end
