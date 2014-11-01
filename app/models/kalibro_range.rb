class KalibroRange < ActiveRecord::Base
  belongs_to :reading
  belongs_to :metric_configuration

  validates :beginning, :end, :reading, :metric_configuration, presence: true
  validates :beginning, uniqueness: {scope: :metric_configuration_id, message: "Should be unique within a Metric Configuration"}
end
