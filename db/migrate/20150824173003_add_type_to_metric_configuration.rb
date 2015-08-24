class AddTypeToMetricConfiguration < ActiveRecord::Migration
  def change
    add_column :metric_configurations, :type, :string
  end
end
