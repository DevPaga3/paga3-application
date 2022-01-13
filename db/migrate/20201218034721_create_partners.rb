class CreatePartners < ActiveRecord::Migration[6.0]
  def change
    create_table :partners do |t|
      t.string :description
      t.boolean :status
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
