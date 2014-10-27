class MezuroRange < ActiveRecord::Base
  belongs_to :reading
  belongs_to :metric_configuration

  def self.ranges_of(metric_configuration_id)
    metric_configuration = MetricConfiguration.find(metric_configuration_id)
    #TODO Waiting for MetricConfiguration model
    metric_configuration.ranges
  end
end
