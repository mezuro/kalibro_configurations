class TreeMetricConfiguration < MetricConfiguration
  belongs_to :reading_group
  has_many :kalibro_ranges, dependent: :destroy, foreign_key: 'metric_configuration_id'

  validates :weight, presence: true
  validates :weight, numericality: { greater_than: 0 }
  validates :aggregation_form, presence: true, if: "native_metric_snapshot?"
end