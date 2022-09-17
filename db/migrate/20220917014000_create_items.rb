class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.string :name, null: false
      t.text :explanation, null: false
      t.integer :without_tax, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
