require 'validators/code_uniqueness_validator'

class MetricConfiguration < ActiveRecord::Base
  belongs_to :kalibro_configuration
  belongs_to :metric_snapshot, dependent: :destroy
  has_many :kalibro_ranges, dependent: :destroy

  validates :metric, code_uniqueness: true
  validates :aggregation_form, :weight, :kalibro_configuration, :metric_snapshot, presence: true
end
