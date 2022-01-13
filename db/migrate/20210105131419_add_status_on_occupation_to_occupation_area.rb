class AddStatusOnOccupationToOccupationArea < ActiveRecord::Migration[6.0]
  def change
    add_column :occupation_areas, :status, :boolean, null: false, default: true
  end
end
