class RemoveColumnFronCompany < ActiveRecord::Migration[6.0]
  def change
    remove_column :companies, :bank_name
    remove_column :companies, :iban
  end
end
