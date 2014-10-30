class Reading < ActiveRecord::Base
  belongs_to :reading_group
  has_many :kalibro_ranges

  validates :label, :grade, :color, :reading_group, presence: true
  validates :label, uniqueness: { scope: :reading_group_id,
    message: "Should be unique within a Reading Group" }
end
