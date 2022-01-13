class AddAccountNumberAndIbanToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :accountNumber, :string
    add_column :companies, :iban, :string
  end
end
