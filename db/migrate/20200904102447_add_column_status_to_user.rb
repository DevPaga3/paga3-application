class AddColumnStatusToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :status, :integer, null: false, default: 1
    add_column :users, :is_active, :boolean, null: false, default: true
  end
end
