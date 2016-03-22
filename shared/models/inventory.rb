class Inventory < ActiveRecord::Base
  self.inheritance_column = nil
  acts_as_paranoid

  belongs_to :collaborator
  belongs_to :operating_system
  belongs_to :team

  before_create :generate_code

  delegate :name, to: :collaborator, prefix: true, allow_nil: true
  delegate :name, to: :team, prefix: true

  enum type: [:book, :appliance, :peripheral, :furniture, :computer, :device]

  has_attached_file :image, styles: { medium: "x180"}
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]

  include PgSearch
  pg_search_scope :seek_code_or_name, against: [:id, :name], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_description, against: [:description], using: { tsearch: { prefix: true  } }

  def generate_code
    symbol = type.first.capitalize
    self.code = symbol + ("%04d" % (Inventory.send(self.type).count + 1))
  end

  def self.search_with code_or_name, description, date, type, team
    search_code_or_name(code_or_name).
    search_description(description).
    include_register_date(date).
    include_type(type).
    include_team(team)
  end

  def self.search_code_or_name code_or_name
    if code_or_name.present?
      seek_code_or_name(code_or_name)
    else
      order("created_at DESC")
    end 
  end

  def self.search_description description
    if description.present?
      seek_description(description)
    else
      order("created_at DESC")
    end     
  end

  def self.include_register_date register_date
    if register_date.present?
      where(register_date: register_date)
    else
      order("created_at DESC")
    end
  end

  def self.include_type type
    if type.present?
      send(type)
    else
      order("created_at DESC")
    end
  end

  def self.include_team team
    if team.present?
      where(team: team)
    else
      order("created_at DESC")
    end
  end
end
