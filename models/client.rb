class Client < ActiveRecord::Base
  self.inheritance_column = nil

  include PgSearch
  acts_as_paranoid

  belongs_to :entity
  belongs_to :partner, class_name: "Client", foreign_key: "partner_id"

  has_many :clients, class_name: "Client", foreign_key: "partner_id"
  has_many :contacts
  has_many :prospects
  has_many :invoices, dependent: :restrict_with_error

  enum type: [:regular, :partner]

  delegate :name, :corporate_name, :address, :phone, :legal_id, :country, :country_name, to: :entity, allow_nil: true
  delegate :type, to: :entity, prefix: true, allow_nil: true

  validates_associated :entity

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  pg_search_scope :seek_name, associated_against: {entity: [:name]}, using: {tsearch: {prefix: true}}
  pg_search_scope :seek_legal_id, associated_against: {entity: [:legal_id]}, using: {tsearch: {prefix: true}}
  pg_search_scope :seek_partner_id, against: [:partner_id], using: { tsearch: { prefix: true  } }

  scope :all_except, ->(client) { where.not(id: client) }

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def partner_name
    partner.nil? ? "" : partner.name
  end

  def self.search_with name, legal_id, type, partner_id
    include_type(type).
    search_name(name).
    search_legal_id(legal_id).
    search_partner(partner_id)
  end

  def self.search_name name
    if name.present?
      seek_name(name)
    else
      order("created_at DESC")
    end       
  end

  def self.search_legal_id legal_id
    if legal_id.present?
      seek_legal_id(legal_id)
    else
      order("created_at DESC")
    end       
  end

  def self.include_type type
    if type.present?
      self.send(type)
    else
      order("created_at DESC")
    end
  end

  def self.search_partner partner_id
    if partner_id.present?
      seek_partner_id(partner_id)
    else
      order("created_at DESC")
    end
  end

  def slug_candidates
    if entity_id.present?
      [
        entity.name,
        [entity.name, entity.legal_id]
      ]
    else
      nil
    end
  end

end
