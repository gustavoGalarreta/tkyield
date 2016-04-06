class Person < ActiveRecord::Base
  acts_as_paranoid

  has_one :contact
  has_one :collaborator
  has_many :relationships
  has_many :collaborators, through: :relationships

  has_attached_file :dni_scan
  validates_attachment_file_name :dni_scan, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]
  has_attached_file :certificate
  validates_attachment_file_name :certificate, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]

  accepts_nested_attributes_for :contact, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :collaborator, reject_if: :all_blank, allow_destroy: true

  enum civil_status: [:single, :married, :widower, :divorced]
  enum gender: [:male, :female]

  delegate :client_name, to: :contact

  validates :first_name, :last_name, presence: true
  validates_format_of :phone, :extension, with: /\A(([ \)])[0-9]{1,3}([ \)]))?([\(][0-9]{1,3}[\)])?([0-9 \.\-]{1,9})\Z/, allow_blank: true
  validates_format_of :mobile, with: /\A([\+][0-9]{1,3}([ \.\-])?)?([\(][0-9]{1,6}[\)])?([0-9 \.\-]{1,11})\Z/, allow_blank: true

  def name
    "#{first_name} #{last_name}"
  end
  alias_method :full_name, :name

  def save_contact
    if contact.nil?
      errors.add(:contact_client,"must be valid.")
      prepare_contact
      false
    else
      self.save
      self.contact.save #slug
      true
    end
  end

  def save_collaborator
    if collaborator.nil?
      errors.add(:collaborator,"must be valid.")
      prepare_collaborator
      return false
    else
      self.save
      if self.errors.empty?
        self.collaborator.save
        return true
      else
        prepare_collaborator
        return false
      end
    end
  end

  def prepare_contact
    build_contact
  end

  def prepare_collaborator
    #general #internal #health
      _collaborator = collaborator || build_collaborator

    #familiar
      unless _collaborator.has_partner?
        _spouse_relationship = _collaborator.build_spouse_relationship
        _spouse_relationship.build_person
      end
      # children_relationship = collaborator.children_relationships.build
      # children_relationship.build_person

    #academic
      # study = collaborator.studies.build
      # study.build_entity

    #laboral
      # job_experience = collaborator.job_experiences.build
      # job_experience.build_entity
      # job_experience.build_reference

    #payment
      _collaborator.build_collaborator_salary_bank unless _collaborator.has_entity? "salary_bank"
      _collaborator.build_collaborator_cts_bank unless _collaborator.has_entity? "cts_bank"
      _collaborator.build_collaborator_pension_entity unless _collaborator.has_entity? "pension_entity"

    #emergency
      unless _collaborator.has_emergency_contact?
        _emergency_relationship = _collaborator.build_emergency_relationship
        _emergency_relationship.build_person
      end
  end

end
