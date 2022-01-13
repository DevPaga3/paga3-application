class CreatePreOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :pre_orders do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.decimal :total_general, null: false, default: 0
      t.decimal :total_commission, null: false, default: 0
      t.decimal :total_without_commission, null: false, default: 0

      t.timestamps
    end
  end
end
