class MetricSnapshot < ActiveRecord::Base
  has_many :metric_configurations

  validates :name, :code, :scope, presence: true
  validates :metric_collector_name, presence: true, if: "type == 'NativeMetric'"
  validates :script, presence: true, if: "type == 'CompoundMetric'"
end
