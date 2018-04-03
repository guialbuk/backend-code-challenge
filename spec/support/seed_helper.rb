module SeedHelper
  def seed_minimal_distances
    Distance.create [{ origin: 'A', destination: 'B', length: 10 },
                     { origin: 'B', destination: 'C', length: 15 },
                     { origin: 'A', destination: 'C', length: 30 }]
  end
end
