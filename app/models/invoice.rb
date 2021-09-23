class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates :status, presence: true

  def self.incomplete_invoices
    joins(:invoice_items).where(invoice_items: {status: [0,1]}).distinct
  end

  def self.order_by_oldest
    incomplete_invoices.order(created_at: :desc)
  end

  enum status: {
    "in progress": 0,
    "cancelled": 1,
    "completed": 2
  }

  def date
    created_at.strftime("%A, %B %d, %Y")
  end

  def customer_name
    
    "#{customer.first_name} #{customer.last_name}"
  end

  def revenue
    items.sum('quantity * invoice_items.unit_price')
  end
end
