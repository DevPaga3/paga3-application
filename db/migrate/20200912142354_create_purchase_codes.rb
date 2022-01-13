class CreatePurchaseCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_codes do |t|
      t.references :user, foreign_key: true
      t.integer :code
      t.boolean :is_active, null: false, default: true
      t.datetime :expiration_at, null: false, default: DateTime.now + 2.minutes
      t.string :slug

      t.timestamps
    end
  end
end
