require 'rails_helper'

describe DijkstraService do
  it 'returns shortest distance' do
    seed_minimal_distances

    expect(DijkstraService.new('A', 'C').shortest_distance).to eq 25
  end

  it 'returns shortest distance in 300 edges' do
    seed_300_distances

    expect(DijkstraService.new('A', 'Z').shortest_distance).to be_kind_of Integer
  end

  it 'returns nil if no route connects origin and detination' do
    seed_minimal_distances
    create :distance, origin: 'D', destination: 'E', length: 8

    expect(DijkstraService.new('A', 'D').shortest_distance).to be_nil
  end

  it 'returns nil if origin or detination does not exist' do
    seed_minimal_distances

    expect(DijkstraService.new('A', 'Z').shortest_distance).to be_nil
  end

  it 'returns nil if there is not any Distance record' do
    expect(DijkstraService.new('A', 'Z').shortest_distance).to be_nil
  end
end
