class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { waiting_for_payment: 0, payment_confirmation: 1, in_production: 2, shipping_preparation: 3, sent: 4 }

  validates :post_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

end
