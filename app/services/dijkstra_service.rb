class DijkstraService
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def shortest_distance
    graph = Dijkstra::Graph.new

    edges = Distance.all.pluck :origin, :destination, :length
    nodes = extract_nodes(edges)

    nodes.each { |node| graph.push node }

    edges.each { |edge| graph.connect_mutually edge[0], edge[1], edge[2].to_i }

    graph.dijkstra(@origin, @destination)
  end

  private

  def extract_nodes(edges)
    nodes = []
    edges.each { |e| nodes.push [e[0], e[1]] }
    nodes.flatten.uniq
  end
end
