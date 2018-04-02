class Distance < ApplicationRecord
  validates :origin, :destination, presence: true
  validates :origin, :destination, format: { with: /\A[A-Z]\Z/,
                                             message: 'only uppercase letters are accepted' }

  validates :length, numericality: { allow_nil: false,
                                     only_integer: true,
                                     greater_than: 0,
                                     less_than_or_equal_to: 100000 }

  validate :origin_not_equal_to_destination
  validate :sorted_origing_and_destination

  def parse_raw_post(payload)
    raw_distance = payload.split
    self.length = raw_distance.pop
    self.origin, self.destination = raw_distance.sort
    self
  end

  private

  def origin_not_equal_to_destination
    return true unless origin == destination
    errors.add(:base, 'origin and destination must be different')
  end

  def sorted_origing_and_destination
    return true if [origin, destination].sort == [origin, destination]
    errors.add(:base, 'origin and destination must be sorted to avoid duplicated distances')
  end
end
