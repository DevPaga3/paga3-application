class RemoveColumnToBank < ActiveRecord::Migration[6.0]
  def change
    remove_column :banks, :configuration_id
    remove_column :banks, :account
    remove_column :banks, :iban

    add_column :banks, :swift, :string
    add_column :banks, :website, :string

  end
end
