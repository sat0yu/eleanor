class Script < ApplicationRecord
  before_validation :fill_length

  has_one :speech
  validates :title, length: { minimum: 1, maximum: 1.kilobytes }
  validates :description, length: { maximum: 128.kilobytes }
  validates :body, length: { minimum: 1, maximum: 4.megabytes }
  validates :length, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def fill_length
    return false if body.blank?
    self.length = body.length
  end
end
