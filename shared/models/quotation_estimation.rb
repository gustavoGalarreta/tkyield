class QuotationEstimation < ActiveRecord::Base
  # acts_as_paranoid

  belongs_to :quotation
  belongs_to :estimation

  def self.developer_total_days
    self.sum(:developer_days_est)
  end

  def self.developer_total_hours
    self.sum(:developer_hours_est)
  end

  def self.designer_total_days
    self.sum(:designer_days_est)
  end

  def self.designer_total_hours
    self.sum(:designer_hours_est)
  end

  def self.account_total_hours
    self.sum(:account_hours_est)
  end

end

