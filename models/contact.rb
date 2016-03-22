class Contact < ActiveRecord::Base
  include PgSearch
  acts_as_paranoid

  belongs_to :person
  belongs_to :client

  has_many :invoice_contacts
  has_many :prospect_contacts
  has_many :invoices, through: :invoice_contacts
  has_many :prospects, through: :prospect_contacts

  delegate :name, to: :client, prefix: true, allow_nil: true
  delegate :name, :first_name, :last_name, :email, :phone, :mobile, :birthday, to: :person, allow_nil: true

  validates_associated :person, :client

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  pg_search_scope :seek_first_name, associated_against: {person: [:first_name]}, using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_last_name, associated_against: {person: [:last_name]}, using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_email, associated_against: {person: [:email]}, using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_client_name,  associated_against: {client: [:name]},using: {tsearch: {prefix: true}}

  def self.search_with first_name, last_name, email, company
    search_first_name(first_name).
    search_last_name(last_name).
    search_email(email).
    include_client_name(company)
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

  def self.search_email email
    if email.present?
      seek_email(email)
    else
      order("created_at DESC")
    end
  end

  def self.include_client_name client_name
    if client_name.present?
      Contact.joins("JOIN clients ON clients.id = contacts.client_id").joins("JOIN entities ON entities.id = clients.entity_id").where("entities.name ILIKE '%' || ? || '%'", client_name)
    else
      order("created_at DESC")
    end    
  end

  def slug_candidates
    if person_id.present?
      [
        person.name,
        [person.name, client_name]
      ]
    else
      nil
    end
  end

  def belongs_to_invoice invoice_id
    if invoice_id.present?
      invoice = Invoice.find(invoice_id)
      invoice.contacts.include? self
    end
  end

  def belongs_to_prospect prospect_id
    if prospect_id.present?
      prospect = Prospect.find(prospect_id)
      prospect.contacts.include? self
    end
  end

  def self.from_client client_id
    Contact.where(client_id: client_id )
  end

end
