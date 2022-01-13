class AddColumnsOccupationAreaProfileIdToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :employer_address, :string
    add_column :profiles, :operating_sector, :integer, default: 0, null: false
    add_column :profiles, :occupationArea_id, :bigint
  end
end
