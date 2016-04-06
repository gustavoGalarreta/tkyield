class Entity < ActiveRecord::Base
  self.inheritance_column = nil
  acts_as_paranoid

  has_one :client
  has_many :job_experiences
  has_many :workers, through: :job_experiences, class_name: "Collaborator"
  has_many :studies
  has_many :students, through: :studies, class_name: "Collaborator"
  has_many :collaborator_entities
  has_many :collaborators, through: :collaborator_entities

  belongs_to :country

  accepts_nested_attributes_for :client, reject_if: :all_blank, allow_destroy: true

  enum type: [:company, :university, :pension, :institute, :organization, :natural_person, :bank, :ong]

  delegate :name, to: :country, prefix: true

  validates :name, :address, :country, presence: true
  validates_format_of :phone, :with => /\A([\+][0-9]{1,3}([ \.\-])?)?([\(][0-9]{1,6}[\)])?([0-9 \.\-]{1,32})(([A-Za-z \:]{1,11})?[0-9]{1,4}?)\z/, allow_blank: true

  def is_peruvian?
    country_id.eql?(173)
  end

  def prepare_client
    build_client
  end

  def save_client
    if client.nil?
      errors.add(:client, "must be valid.")
      prepare_client
      return false
    else
      self.save
      if self.errors.empty?
        self.client.save
        return true
      else
        prepare_client
        return false
      end
    end
  end

end
