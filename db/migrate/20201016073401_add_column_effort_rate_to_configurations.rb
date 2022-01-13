class AddColumnEffortRateToConfigurations < ActiveRecord::Migration[6.0]
  def change
    add_column :configurations, :effort_rate, :integer, null: false, default: 40
  end
end
