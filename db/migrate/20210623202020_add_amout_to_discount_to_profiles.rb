class AddAmoutToDiscountToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :amount_to_discount, :decimal
  end
end
