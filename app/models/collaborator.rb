class Collaborator < ActiveRecord::Base
  self.inheritance_column = nil
  has_many :collaborator_projects
  has_many :schedules
  has_many :event_logs, dependent: :destroy
  has_many :projects, through: :collaborator_projects
  belongs_to :team
  belongs_to :person

  scope :active, -> {where(archived_at: nil)}
  #scope :archived, -> {where.not(archived_at: nil)}
  #scope :without_team, -> {where(team_id: nil)}
  delegate :first_name, :last_name, :dni, :email, :birthday, :mobile, :phone, to: :person

  def update_collaborator params
  	person = Person.find(self.person_id)
  	person_params = {"first_name" => params["first_name"], "last_name" => params["last_name"]}
  	collaborator_params = {"work_mail" => params["work_mail"], "team_id" => params["team_id"]}
  	if self.update_attributes(collaborator_params) and person.update_attributes(person_params)
  		return true
  	else 
  		return false
  	end
  end

  def pin
    sprintf '%04d', code
  end

  def current_schedule
    self.schedules.where(current: true).first
  end

  def full_name
    first_name + " " + last_name
  end
  alias_method :name, :full_name

  #def archive!
	  #if self.archived_at.nil?
	    #self.update_attributes(archived_at: Time.zone.now)
	    #self.cancel_active_timesheet
	   # self.check_out
	  #else
	  #  false
	 # end
	#end

	#def unarchive!
	  #if self.archived_at.nil?
	  #  false
	  #else
	  #  self.update_attributes(archived_at: nil)
	 # end
	#end



  #def archived?
  #  !archived_at.nil?
  #end

end