class ShortestDistanceService
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def calculate
    # Prevents exhaustive search for non-existing origin or destination
    return nil unless location_exists?(@origin) && location_exists?(@destination)
    99 # TODO
  end

  private

  def location_exists?(location)
    Distance.where('origin = ? OR destination = ?', location, location).take
  end
end
