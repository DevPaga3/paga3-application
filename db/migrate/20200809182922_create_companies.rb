class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :nif
      t.string :address
      t.string :cell_phone
      t.string :bank_name
      t.string :iban
      t.references :user, null: true, foreign_key: true, index: true

      t.timestamps
    end
  end
end
