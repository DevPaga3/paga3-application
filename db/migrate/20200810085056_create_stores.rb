class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :reference_number
      t.string :description
      t.string :location
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
