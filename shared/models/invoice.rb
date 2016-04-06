class Invoice < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include PgSearch

  belongs_to :client
  belongs_to :currency
  belongs_to :headquarter

  has_attached_file :document, styles: { medium: "400x600>"}
  validates_attachment_file_name :document, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]
  
  has_attached_file :purchase_order, styles: { medium: "400x600>"}
  validates_attachment_file_name :purchase_order, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]

  has_attached_file :pdf, :url => Rails.application.config.action_controller.relative_url_root.to_s + "/system/:class/:attachment/:id_partition/:style/:basename.:extension", 
    :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:basename.:extension", 
    :default_url => Rails.application.config.action_controller.relative_url_root.to_s + "/images/:style/missing.pdf"
  
  has_many :invoice_contacts
  has_many :contacts, through: :invoice_contacts

  acts_as_paranoid

  validates :client_id, :description, :currency_id, :amount, :status, presence: true

  accepts_nested_attributes_for :invoice_contacts, allow_destroy: true

  delegate :name, :legal_id, :address, to: :client, prefix: true, allow_nil: true

  pg_search_scope :seek_ruc, against: [:ruc], using: { tsearch: { prefix: true  } }
  pg_search_scope :seek_invoice_number, against: [:invoice_number], using: { tsearch: { prefix: true  } }

  enum status: [:to_issue, :issued, :partial_payment, :canceled, :paid ]
  enum payment_type: [:transference, :check]

  def self.search_with company, ruc, invoice_number, from_date, to_date, status
    search_invoice_number(invoice_number).
    search_client_name(company).
    search_client_ruc(ruc).
    to_date(to_date).
    from_date(from_date).
    include_status(status)
  end

  def self.search_invoice_number invoice_number
    if invoice_number.present?
      seek_invoice_number(invoice_number)
    else
      order("created_at DESC")
    end     
  end

  def self.from_date from_date
    if from_date.present?
      where("created_at > ?", from_date.to_datetime)
    else
      order("created_at DESC")
    end      
  end

  def self.to_date to_date
     if to_date.present?
      where("created_at < ?", to_date.to_datetime)
    else
      order("created_at DESC")
    end
  end

  def self.search_client_name company
    if company.present?
      Invoice.joins("JOIN clients ON clients.id = invoices.client_id").joins("JOIN entities ON entities.id = clients.entity_id").where("entities.name =?", company)
    else
      order("created_at DESC")
    end    
  end

  def self.search_client_ruc ruc
    if ruc.present?
      Invoice.joins("JOIN clients ON clients.id = invoices.client_id").joins("JOIN entities ON entities.id = clients.entity_id").where("entities.legal_id =?", ruc)
    else
      order("created_at DESC")
    end
  end

  def self.include_status status
    if status.present?
      Invoice.send(status)
    else
      order("created_at DESC")
    end
  end

  def self.total_amount invoices, currency_id
    amount = invoices.select{|invoice| invoice.currency_id == currency_id }.sum(&:amount)
    '%.2f' % amount
  end

  def self.total_soles invoices
    self.total_amount(invoices, Currency.currency_id('Sol'))
  end

  def self.total_dolar invoices
    self.total_amount(invoices, Currency.currency_id('Dollar'))
  end

  def amount_decimal
    number_with_precision(amount, :precision => 2) || 0
  end

  def invoice_igv
    number_with_precision(amount * headquarter.country.igv.to_f, :precision => 2) || 0
  end

  def invoice_total
    number_with_precision(amount + invoice_igv.to_f, :precision => 2) || 0
  end

  def invoice_drawdown
    has_drawdown  ? number_with_precision(amount * headquarter.country.drawdown, :precision => 2) || 0 : 0
  end

  def invoice_balance
    invoice_total.to_f - invoice_drawdown.to_f
  end


  def generate_pdf
    pdf = InvoicePDF.new(self, headquarter)
    attachment = pdf.render
    attachment
  end

  def generate_pdf_file attachment
    file = StringIO.new(attachment) #mimic a real upload file
    file.class.class_eval { attr_accessor :original_filename, :content_type } #add attr's that paperclip needs
    file.original_filename = "invoice_#{invoice_number}.pdf"
    file.content_type = "application/pdf"
    file
  end

  def self.get_contacts_per_client client
    unless client.nil?
      return Client.find(client["contact_id"]).contacts
    end
  end


end