class InvoiceContact < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :invoice
  belongs_to :contact
end