class Speech < ApplicationRecord
  belongs_to :script
  validates :url, length: { minimum: 1, maximum: 128.kilobytes }
  validates :size, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
