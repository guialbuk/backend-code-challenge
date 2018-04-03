class Cost
  include ActiveModel::Validations

  attr_accessor :origin, :destination, :weight

  validates :origin, :destination, presence: true

  validates :origin, :destination,
            format: { with: /\A[A-Z]+\Z/,
                      message: 'must have only uppercase letters and no accents' }

  validates :weight, numericality: { allow_nil: false,
                                     only_integer: true,
                                     greater_than: 0,
                                     less_than_or_equal_to: 50 }

  validate :origin_not_equal_to_destination

  def initialize(params = nil)
    return unless params
    @origin = params[:origin]
    @destination = params[:destination]
    @weight = params[:weight]
  end

  def calculate_shipping
    distance = ShortestDistanceService.new(origin, destination).calculate
    distance ? format('%.2f', distance * weight.to_i * 0.15) : nil
  end

  private

  def origin_not_equal_to_destination
    return true unless origin == destination
    errors.add(:base, 'origin and destination must be different')
  end
end
