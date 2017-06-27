class MetricSnapshot < ActiveRecord::Base
  has_one :metric_configuration

  validates :name, :code, :scope, presence: true
  validates :metric_collector_name, presence: true, if: "type == 'NativeMetricSnapshot' || type == 'HotspotMetricSnapshot'"
  validates :script, presence: true, if: "type == 'CompoundMetricSnapshot'"

  def as_json(options = {})
    super(options)
    # This method should be implemented in child classes
  end

  def scope=(value)
    value.is_a?(Hash) ? super(value['type']) : errors.add(:scope, "#{value} invalid")
  end
end
