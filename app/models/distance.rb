class Distance < ApplicationRecord
  validates :origin, :destination, presence: true
  validates :origin, :destination,
            format: { with: /\A[A-Z]+\Z/,
                      message: 'must have only uppercase letters and no accents' }

  validates :length, numericality: { allow_nil: false,
                                     only_integer: true,
                                     greater_than: 0,
                                     less_than_or_equal_to: 100000 }

  validate :origin_not_equal_to_destination
  validate :sorted_origing_and_destination

  def update_or_create
    record = Distance.where('origin = ? AND destination = ?', origin, destination).limit(1)

    record.any? ? record.update(length: length) : save
  end

  def parse_raw_post(payload)
    return self unless raw_post_format payload

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

  def raw_post_format(payload)
    return true if payload =~ /\A[A-Z]+ [A-Z]+ [0-9]+\Z/i # downcase letters have their own validator
    errors.add(:base, 'incorrect post format. It must be "A B 10"')
    false
  end
end
