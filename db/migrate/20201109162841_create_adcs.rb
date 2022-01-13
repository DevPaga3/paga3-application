class CreateAdcs < ActiveRecord::Migration[6.0]
  def change
    create_table :adcs do |t|
      t.references :factura, foreign_key: true
      t.references :profile, foreign_key: true
      t.string :reference
      t.string :slug

      t.timestamps
    end
  end
end
