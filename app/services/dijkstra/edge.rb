# Based on Yuichi Araki's Dijkstra implementation
# https://gist.github.com/yaraki/1730288

class Dijkstra::Edge
  attr_accessor :src, :dst, :length

  def initialize(src, dst, length = 1)
    @src = src
    @dst = dst
    @length = length
  end
end
