class KalibroConfiguration < ActiveRecord::Base
  has_many :metric_configurations, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
