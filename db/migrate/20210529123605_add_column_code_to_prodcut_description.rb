class AddColumnCodeToProdcutDescription < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :description, :string
  end
end
