class RemoveColumnIbanAndBankToProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :bank_name
    remove_column :profiles, :iban
  end
end


