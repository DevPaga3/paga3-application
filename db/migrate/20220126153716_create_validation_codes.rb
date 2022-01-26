class CreateValidationCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :validation_codes do |t|
      t.string :code
      t.boolean :status, null: false, default: false
      t.string :cell_phone
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
