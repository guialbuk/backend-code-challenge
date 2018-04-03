distances = []

('A'..'Z').each do |origin|
  (origin..'Z').to_a[1..-1].each do |destination|
    distances.push(origin: origin,
                   destination: destination,
                   length: rand(5..10))
  end
end

Distance.create distances
