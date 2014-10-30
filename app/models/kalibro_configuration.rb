class KalibroConfiguration < ActiveRecord::Base
  has_many :metric_configurations

  validates :name, presence: true
end
