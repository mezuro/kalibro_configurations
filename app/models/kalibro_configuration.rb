class KalibroConfiguration < ActiveRecord::Base
  has_many :metric_configurations

  def self.metric_configurations_of(configuration_id)
    kalibro_configuration = KalibroConfiguration.find(configuration_id)
    kalibro_configuration.metric_configurations
  end
end
