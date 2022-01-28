class AddColumnResidenceToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :last_name, :string
    add_column :profiles, :province, :string
    add_column :profiles, :residence, :string
  end
end
