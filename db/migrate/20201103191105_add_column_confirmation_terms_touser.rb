class AddColumnConfirmationTermsTouser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :confirmation_terms, :boolean, null: false, default: false
  end
end
