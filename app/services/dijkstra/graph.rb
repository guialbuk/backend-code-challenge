# Based on Yuichi Araki's Dijkstra implementation
# https://gist.github.com/yaraki/1730288

class Dijkstra::Graph < Array
  attr_reader :edges

  def initialize
    @edges = []
  end

  def connect(src, dst, length = 1)
    raise ArgumentException, "No such vertex: #{src}" unless include?(src)
    raise ArgumentException, "No such vertex: #{dst}" unless include?(dst)
    @edges.push Dijkstra::Edge.new(src, dst, length)
  end

  def connect_mutually(vertex1, vertex2, length = 1)
    connect vertex1, vertex2, length
    connect vertex2, vertex1, length
  end

  def neighbors(vertex)
    neighbors = []
    @edges.each { |edge| neighbors.push edge.dst if edge.src == vertex }
    neighbors.uniq
  end

  def length_between(src, dst)
    @edges.each do |edge|
      return edge.length if (edge.src == src) && (edge.dst == dst)
    end
    nil
  end

  def dijkstra(src, dst)
    distances = {}
    previouses = {}

    each do |vertex|
      distances[vertex] = nil # Infinity
      previouses[vertex] = nil
    end

    distances[src] = 0
    vertices = clone

    until vertices.empty?
      nearest_vertex = vertices.inject do |a, b|
        next b unless distances[a]
        next a unless distances[b]
        next a if distances[a] < distances[b]
        b
      end
      
      break unless distances[nearest_vertex] # Infinity
      return distances[dst] if dst && (nearest_vertex == dst)

      neighbors = vertices.neighbors(nearest_vertex)

      neighbors.each do |vertex|
        alt = distances[nearest_vertex] + vertices.length_between(nearest_vertex, vertex)
        next unless distances[vertex].nil? || (alt < distances[vertex])
        distances[vertex] = alt
        previouses[vertex] = nearest_vertex
      end

      vertices.delete nearest_vertex
    end
  end
end
