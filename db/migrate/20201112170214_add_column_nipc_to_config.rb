class AddColumnNipcToConfig < ActiveRecord::Migration[6.0]
  def change
    add_column :configurations, :nipc, :string, null: false, default: '1234567890'
    add_column :configurations, :iec, :string, null: false, default: 'AO9834567890'
    add_column :configurations, :province, :string, null: false, default: ''
    add_column :configurations, :municipality, :string, null: false, default: ''
  end
end
