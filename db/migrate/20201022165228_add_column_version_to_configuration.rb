class AddColumnVersionToConfiguration < ActiveRecord::Migration[6.0]
  def change
    add_column :configurations, :version, :string, null: false, default: 'V1.0.0'
  end
end
