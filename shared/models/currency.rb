class Currency < ActiveRecord::Base

  has_many :quotations

  has_many :invoices

  def self.currency_symbol name
    find_by(name: name).symbol
  end

  def self.currency_id name
    find_by(name: name).id
  end


end
