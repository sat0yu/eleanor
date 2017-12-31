class Speech < ApplicationRecord
  belongs_to :script
  validates :url, length: { minimum: 1, maximum: 128.kilobytes }
end
