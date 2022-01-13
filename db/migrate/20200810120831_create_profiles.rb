class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :bi
      t.decimal :salary, null: false, default: 0
      t.string :position
      t.string :company_name
      t.string :address
      t.datetime :birth
      t.integer :status, null: false, default: 0
      t.integer :genre, null: false, default: 0
      t.boolean :have_credit, null: false, default: false
      t.decimal :amount_credit, null: false, default: 0
      t.decimal :percentage_valid, null: false, default: 0
      t.decimal :purchase_amount, null: false, default: 0
      t.references :user, null: true, foreign_key: true

      t.string :bank_name
      t.string :iban

      t.timestamps
    end
  end
end


