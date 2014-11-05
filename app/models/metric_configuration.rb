require 'validators/code_uniqueness_validator'

class MetricConfiguration < ActiveRecord::Base
  belongs_to :kalibro_configuration
  belongs_to :metric_snapshot
  has_many :kalibro_ranges, dependent: :destroy
  before_destroy :destroy_compound_metric

  validates :metric, code_uniqueness: true
  validates :aggregation_form, :weight, :kalibro_configuration, :metric_snapshot, presence: true

  private

  def destroy_compound_metric
    if self.metric_snapshot.type == "CompoundMetric"
      self.metric_snapshot.destroy
    end
  end
end
