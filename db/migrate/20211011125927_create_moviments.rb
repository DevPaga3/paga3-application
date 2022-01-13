class CreateMoviments < ActiveRecord::Migration[6.0]
  def change
    create_table :moviments do |t|
      t.references :profile, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :is_credit, null: false, default: true
      t.decimal :amount, null: false, default: 0

      t.timestamps
    end
  end
end
