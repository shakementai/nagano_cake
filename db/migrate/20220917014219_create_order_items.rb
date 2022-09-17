class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      
      t.integer :amount, null: false
      t.integer :purchase_price, null: false
      t.integer :production_status, null: false, default: 0

      t.timestamps
    end
  end
end
