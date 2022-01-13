class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts do |t|
      t.references :accountble, polymorphic: true
      t.string :iban
      t.string :account_number
      t.references :bank, null: true, foreign_key: true
      
      t.timestamps
    end
  end
end
