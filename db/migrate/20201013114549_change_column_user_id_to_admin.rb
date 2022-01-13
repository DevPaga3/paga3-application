class ChangeColumnUserIdToAdmin < ActiveRecord::Migration[6.0]
  def change
    change_column :admins, :user_id, :integer, null: true
  end
end
