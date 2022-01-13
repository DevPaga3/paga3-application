class CreateOccupationAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :occupation_areas do |t|
      t.string :occupation
      t.text :description

      t.timestamps
    end
  end
end
