class ReadingGroup < ActiveRecord::Base
  has_many :readings, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
