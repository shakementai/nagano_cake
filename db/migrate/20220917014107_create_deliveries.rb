class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|

      t.string :post_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :customer_id, null: false

      t.timestamps
    end
  end
end
