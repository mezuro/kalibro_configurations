class MetricConfiguration < ActiveRecord::Base
  attr_accessor :kalibro_configuration

  belongs_to :kalibro_configuration
end
