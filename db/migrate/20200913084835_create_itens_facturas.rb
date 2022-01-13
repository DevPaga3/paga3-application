class CreateItensFacturas < ActiveRecord::Migration[6.0]
  def change
    create_table :itens_facturas do |t|
      t.references :factura, foreign_key: true
      t.string :name
      t.decimal :real_price, null: false, default: 0
      t.integer :render_number, null: false, default: 0
      t.decimal :price_with_commission, default: 0, null: false
      t.decimal :commission_amount, default: 0, null: false
      t.string :slug
      t.string :code
      
      t.timestamps
    end
  end
end
