class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      t.string :post_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :payment_method, null: false, default: 0
      t.integer :shipping_cost, null: false
      t.integer :total_price, null: false
      t.integer :order_status, null: false, default: 0

      t.timestamps
    end
  end
end
