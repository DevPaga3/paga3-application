class AddColumnSatusToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :status, :boolean, null: false, default: true
  end
end
