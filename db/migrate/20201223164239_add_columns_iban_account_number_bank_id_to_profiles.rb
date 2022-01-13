class AddColumnsIbanAccountNumberBankIdToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :iban, :string
    add_column :profiles, :account_number, :string
    add_column :profiles, :bank_id, :bigint
  end
end
