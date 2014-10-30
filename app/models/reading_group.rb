class ReadingGroup < ActiveRecord::Base
  has_many :readings

  validates :name, presence: true
end
