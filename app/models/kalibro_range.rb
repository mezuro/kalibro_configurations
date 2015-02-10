require 'validators/interval_validator.rb'
require 'validators/range_overlapping_validator.rb'

class KalibroRange < ActiveRecord::Base
  belongs_to :reading
  belongs_to :metric_configuration

  validates :beginning, :end, :reading, :metric_configuration, presence: true
  validates :beginning, uniqueness: {scope: :metric_configuration_id, message: "Should be unique within a Metric Configuration"}
  validates :beginning, :end, numericality: true
  validates_with IntervalValidator, fields: [:beginning, :end], if: "beginning && self.end"
  validates_with RangeOverlappingValidator, fields: [:beginning, :end], if: "beginning && self.end"

  def as_json(options={})
    options[:except] = [:beginning, :end]
    json = super(options)
    json['beginning'] = (beginning == -Float::INFINITY ? "-INF" : (beginning == Float::INFINITY ? "INF" : beginning))
    json['end'] = (self.end == -Float::INFINITY ? "-INF" : (self.end == Float::INFINITY ? "INF" : self.end))

    return json
  end

end
