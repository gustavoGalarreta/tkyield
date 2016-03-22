class Collaborator < ActiveRecord::Base
  self.inheritance_column = nil
  include PgSearch
  acts_as_paranoid

  belongs_to :person
  belongs_to :team
  belongs_to :referred_by, foreign_key: "reference_id", class_name: "Collaborator"

  has_many :events
  has_many :prospects
  has_many :inventories
  has_many :references, foreign_key: "reference_id", class_name: "Collaborator"
  has_many :collaborator_entities
  has_many :entities, through: :collaborator_entities
  has_many :studies
  has_many :relationships
  has_many :people, through: :relationships
  has_many :relative_relationships, -> { where(type: Relationship.types[:relative]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_many :relative, through: :relative_relationships, class_name: "Person"
  has_one :spouse_relationship, -> { where(type: Relationship.types[:spouse]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_one :spouse, through: :spouse_relationship, source: "person"
  has_many :children_relationships, -> { where(type: Relationship.types[:children]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_many :children, through: :children_relationships, source: "person"
  has_many :parental_relationship, -> { where(type: Relationship.types[:parental]) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_many :parents, through: :parental_relationship, source: "person"
  has_many :job_experiences
  has_many :job_entities, through: :job_experiences, class_name: "Entity"
  has_one :collaborator_salary_bank, -> { where(type: CollaboratorEntity.types[:salary]) }, foreign_key: "collaborator_id", class_name: "CollaboratorEntity"
  has_one :salary_bank, through: :collaborator_salary_bank, source: "entity"
  has_one :collaborator_cts_bank, -> { where(type: CollaboratorEntity.types[:cts]) }, foreign_key: "collaborator_id", class_name: "CollaboratorEntity"
  has_one :cts_bank, through: :collaborator_cts_bank, source: "entity"
  has_one :collaborator_pension_entity, -> { where(type: CollaboratorEntity.types[:pension]) }, foreign_key: "collaborator_id", class_name: "CollaboratorEntity"
  has_one :pension_entity, through: :collaborator_pension_entity, source: "entity"
  has_one :emergency_relationship, -> { where(emergency: true) }, foreign_key: "collaborator_id", class_name: "Relationship"
  has_one :emergency_contact, through: :emergency_relationship, source: "person"

  accepts_nested_attributes_for :spouse_relationship, reject_if: :reject_relationship, allow_destroy: true
  accepts_nested_attributes_for :spouse, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :children_relationships, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :emergency_relationship, reject_if: :reject_relationship, allow_destroy: true
  accepts_nested_attributes_for :emergency_contact, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :job_experiences, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :job_entities, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :studies, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :collaborator_salary_bank, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :collaborator_cts_bank, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :collaborator_pension_entity, reject_if: :all_blank, allow_destroy: true

  enum type: [:practice, :payroll, :professional]
  enum status: [:active, :inactive, :former, :expelled]
  enum blood_type: [:o_positive, :a_positive, :b_positive, :ab_positive, :o_negative, :a_negative, :b_negative, :ab_negative]
  enum insurance: [:fola, :eps]

  delegate :first_name, :last_name, :dni, :email, :birthday, :mobile, :phone, to: :person
  delegate :name, to: :team, prefix: true, allow_nil: true

  pg_search_scope :seek_first_name, associated_against: { person: [:first_name] }, using: { tsearch: { prefix: true }}
  pg_search_scope :seek_last_name, associated_against: { person: [:last_name] }, using: { tsearch: { prefix: true }}

  scope :team, -> (team_id) { where(team: team_id)}
  scope :team_name, -> (name) { joins("JOIN teams ON teams.name = '#{name}' AND teams.id = collaborators.team_id")}

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  has_attached_file :before_employment_test
  validates_attachment_file_name :before_employment_test, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]
  has_attached_file :around_employment_test
  validates_attachment_file_name :around_employment_test, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]
  has_attached_file :after_employment_test
  validates_attachment_file_name :after_employment_test, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]

  def full_name
    first_name + " " + last_name
  end
  alias_method :name, :full_name

  def self.search_with first_name, last_name, month, start_date
    search_first_name(first_name).
    search_last_name(last_name).
    include_birthday(month).
    include_start_date(start_date)
  end

  def self.search_first_name first_name
    if first_name.present?
      seek_first_name(first_name)
    else
      order("created_at DESC")
    end       
  end

  def self.search_last_name last_name
    if last_name.present?
      seek_last_name(last_name)
    else
      order("created_at DESC")
    end       
  end

  def self.include_birthday month
    if month.present?
      joins(:person).where("extract(month from birthday) = ?", month)
    else
      order("created_at DESC")
    end 
  end

  def self.include_start_date str_date
    if str_date.present?
      start_date = Date.strptime(str_date,"%m-%Y")
      where("extract(year from first_day) = ? AND extract(month from first_day) = ?", start_date.to_date.year, start_date.to_date.month)
    else
      order("created_at DESC")
    end 
  end

  def has_family?
    has_partner? || has_children?
  end

  def has_partner?
    !spouse.nil?
  end

  def has_children?
    !children.empty?
  end

  def has_emergency_contact?
    !emergency_contact.nil?
  end

  def has_entity? type
    !send("collaborator_#{type}").nil?
  end

  def reject_relationship attributes
    attributes["person_attributes"].values.all? {|x| x.blank?}
  end

  def slug_candidates
    if person_id.present?
      [
        person.name,
        [person.name, code]
      ]
    else
      nil
    end
  end

end
