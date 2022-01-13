class AddCategoryToCompany < ActiveRecord::Migration[6.0]
  def change
    add_reference :companies, :category, foreign_key: true
  end
end
