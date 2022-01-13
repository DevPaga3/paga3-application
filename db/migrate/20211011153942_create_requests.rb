class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :profile, foreign_key: true
      t.string :store
      t.string :address
      t.string :cell_phone
      t.string :email
      t.string :product
      t.decimal :price, null: false, default: 0
      t.integer :render_number, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
