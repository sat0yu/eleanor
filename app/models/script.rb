class Script < ApplicationRecord
  has_one :speech
  validates :title, length: { minimum: 1, maximum: 1.kilobytes }
  validates :body, length: { minimum: 1, maximum: 4.megabytes }
end
