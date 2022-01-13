class CreateHistoryOfProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :history_of_profiles do |t|
      t.references :user, foreign_key: true
      t.references :profile, foreign_key: true
      t.decimal :purchase_amount, default: 0, null:false
      t.decimal :amount_to_discount, default: 0, null:false
      t.decimal :final_value, default: 0, null:false

      t.timestamps
    end
  end
end
