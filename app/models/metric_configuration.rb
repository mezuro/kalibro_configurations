class MetricConfiguration < ActiveRecord::Base
  belongs_to :kalibro_configuration
  has_many :kalibro_ranges
end
