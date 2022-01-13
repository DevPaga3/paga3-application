class AddColumnToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :numbers, :string
  end
end
