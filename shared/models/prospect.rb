class Prospect < ActiveRecord::Base
  self.inheritance_column = nil
  acts_as_paranoid

  belongs_to :client
  belongs_to :team

  has_many :estimations
  has_many :quotations
  has_many :prospect_contacts
  has_many :contacts, through: :prospect_contacts

  enum type: [:fixed_price, :times_x_material]
  enum status: [:received, :at_estimation, :sent_id, :accepted, :canceled]

  accepts_nested_attributes_for :prospect_contacts, :allow_destroy => true

  validates :client, presence: true

  delegate :name, :type, :country_id, to: :client, prefix: true, allow_nil: true
  delegate :partner_name, to: :client, prefix: true
  delegate :name, to: :team, prefix: true

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  include PgSearch
  pg_search_scope :seek_name, against: [:name], using: { tsearch: { prefix: true  } }

  scope :partner, -> { joins('JOIN "clients" ON "clients"."id" = "prospects"."client_id" AND "clients"."deleted_at" IS NULL').merge(Client.partner) }
  scope :regular, -> { joins('JOIN "clients" ON "clients"."id" = "prospects"."client_id" AND "clients"."deleted_at" IS NULL').merge(Client.regular) }

  def self.search_with name, company, status, prospect_type, country_id, client_type, partner_id
    search_name(name).
    search_client_name(company).
    search_client_country(country_id).
    include_status(status)
  end

  def self.search_name name
    if name.present?
      seek_name(name)
    else
      order("created_at DESC")
    end       
  end

  def self.search_client_name company
    if company.present?
      Prospect.joins("JOIN clients ON clients.id = prospects.client_id").joins("JOIN entities ON entities.id = clients.entity_id").where("entities.name =?", company)
    else
      order("created_at DESC")
    end  
  end

  def self.search_client_country country_id
    if country_id.present?
      Prospect.joins("JOIN clients ON clients.id = prospects.client_id").joins("JOIN entities ON entities.id = clients.entity_id").where("entities.country_id = ?", country_id)
    else
      order("created_at DESC")
    end
  end

  def self.include_status status
    if status.present?
      Prospect.send(status)
    else
      order("created_at DESC")
    end
  end


  def slug_candidates
    [
      name,
      [name, client_name],
      [name, client_name, type],
      [name, client_name, type, arrival_date]
    ]
  end

end
