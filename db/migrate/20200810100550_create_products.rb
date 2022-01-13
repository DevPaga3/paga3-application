class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price_with_commission, null: false, default: 0
      t.decimal :real_price, null: false, default: 0
      t.decimal :commission_amount, null: false, default: 0
      t.string :code
      t.string :render_number, default: 3, null: false
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
