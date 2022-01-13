class AddColumnInSiteToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :show_in_site, :boolean, null: false, default: false
  end
end
