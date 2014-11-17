class MetricConfiguration < ActiveRecord::Base
  belongs_to :kalibro_configuration
  belongs_to :metric_snapshot, dependent: :destroy
  has_many :kalibro_ranges, dependent: :destroy

  validates :aggregation_form, :weight, :kalibro_configuration, :metric_snapshot, presence: true
  validates :weight, numericality: { greater_than: 0 }
  validates :metric_snapshot, uniqueness: { scope: :kalibro_configuration_id,
    message: "Should be unique within a Kalibro Configuration" }

  accepts_nested_attributes_for :metric_snapshot
end
