class AddColumnCanEditToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :can_edit, :boolean, null: false, default: false
  end
end
