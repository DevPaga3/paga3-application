class AddSlugToAllTables < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles,         :slug, :string, null: true
    add_column :admins,           :slug, :string, null: true
    add_column :bank_accounts,    :slug, :string, null: true
    add_column :banks,            :slug, :string, null: true
    add_column :companies,        :slug, :string, null: true
    add_column :item_orders,      :slug, :string, null: true
    add_column :pre_orders,       :slug, :string, null: true
    add_column :products,         :slug, :string, null: true
    add_column :stores,           :slug, :string, null: true
    add_column :users,            :slug, :string, null: true
  end

end
