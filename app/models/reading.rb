class Reading < ActiveRecord::Base
  belongs_to :reading_group
  has_many :kalibro_ranges
end
