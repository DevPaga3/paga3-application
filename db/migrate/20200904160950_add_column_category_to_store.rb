class AddColumnCategoryToStore < ActiveRecord::Migration[6.0]
  def change
    add_reference :stores, :category, foreign_key: true, null: true
  end
end
