class MetricConfiguration < ActiveRecord::Base
  belongs_to :kalibro_configuration
  belongs_to :metric
  has_many :kalibro_ranges

  validates_associated :metric
  validates :aggregation_form, :weight, :kalibro_configuration, :metric, presence: true
end
