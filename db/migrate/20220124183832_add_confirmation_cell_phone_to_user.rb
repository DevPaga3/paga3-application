class AddConfirmationCellPhoneToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :confirmation_cell_phone, :boolean, null: false, default: false
  end
end
