class ReadingGroup < ActiveRecord::Base
  has_many :readings, dependent: :destroy
  has_many :metric_configurations, class_name: 'TreeMetricConfiguration'

  validates :name, presence: true, uniqueness: true
end
