class AddColumnToHistoryOfProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :history_of_profiles, :is_credit, :boolean, null: false, default: false
  end
end
