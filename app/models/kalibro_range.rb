class KalibroRange < ActiveRecord::Base
  belongs_to :reading
  belongs_to :metric_configuration

  def self.ranges_of(metric_configuration_id)
    metric_configuration = MetricConfiguration.find(metric_configuration_id)
    metric_configuration.kalibro_ranges
  end
end
