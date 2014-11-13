class MetricSnapshot < ActiveRecord::Base
  has_one :metric_configuration

  validates :name, :code, :scope, presence: true
  validates :metric_collector_name, presence: true, if: "type == 'NativeMetricSnapshot'"
  validates :script, presence: true, if: "type == 'CompoundMetricSnapshot'"
end
