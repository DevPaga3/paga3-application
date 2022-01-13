class CreateItemOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :item_orders do |t|
      t.references :product, null: false, foreign_key: true
      t.references :pre_order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
