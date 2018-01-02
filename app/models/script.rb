class Script < ApplicationRecord
  has_one :speech
  validates :title, length: { minimum: 1, maximum: 1.kilobytes }
  validates :description, length: { maximum: 128.kilobytes }
  validates :body, length: { minimum: 1, maximum: 4.megabytes }
  validates :length, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
