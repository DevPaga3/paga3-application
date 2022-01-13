class CreateCompanyBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :company_banks do |t|
      t.string :iban
      t.string :account
      t.references :bank, null: true, foreign_key: true

      t.timestamps
    end
  end
end

