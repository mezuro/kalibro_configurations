require 'validators/code_uniqueness_validator'

class MetricConfiguration < ActiveRecord::Base
  belongs_to :kalibro_configuration
  belongs_to :metric
  has_many :kalibro_ranges, dependent: :destroy
  before_destroy :destroy_compound_metric

  validates :metric, code_uniqueness: true
  validates :aggregation_form, :weight, :kalibro_configuration, :metric, presence: true

  private

  def destroy_compound_metric
    if self.metric.type == "CompoundMetric"
      self.metric.destroy
    end
  end
end
