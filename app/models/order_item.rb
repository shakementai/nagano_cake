class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  enum production_status: {cannot_start: 0, production_wait: 1, producting: 2, product_complete: 3}

end
