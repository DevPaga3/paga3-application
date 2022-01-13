class DropCompanyBanksTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :company_banks, if_exists: true
  end
end
