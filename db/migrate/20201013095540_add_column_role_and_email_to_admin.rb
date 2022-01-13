class AddColumnRoleAndEmailToAdmin < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :role, :integer, null: false, default: 10
    add_column :admins, :email, :string
  end
end
