class CreateRecibos < ActiveRecord::Migration[6.0]
  def change
    create_table :recibos do |t|
      t.references :factura, foreign_key: true
      t.decimal :valor, null: false, default: 0
      t.string :slug

      t.timestamps
    end
  end
end
