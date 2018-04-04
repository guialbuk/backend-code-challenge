module SeedHelper
  def seed_minimal_distances
    Distance.create [{ origin: 'A', destination: 'B', length: 10 },
                     { origin: 'B', destination: 'C', length: 15 },
                     { origin: 'A', destination: 'C', length: 30 }]
  end

  def seed_300_distances
    distances = []

    ('A'..'Z').each do |origin|
      (origin..'Z').to_a[1..-1].each do |destination|
        distances.push(origin: origin,
                       destination: destination,
                       length: rand(5..10))
      end
    end

    Distance.create distances
  end

  def thousand_distances_array
    distances = []

    ('A'..'Z').each do |origin|
      (origin..'Z').to_a[1..-1].each do |destination|
        distances.push origin, destination, rand(5..10)
      end
    end

    distances
  end
end
