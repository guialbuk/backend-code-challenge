require 'rails_helper'

describe ShortestDistanceService do
  it 'returnsnil if origin or detination does not exist' do
    expect(ShortestDistanceService.new('A', 'B').calculate).to be_nil
  end

  it 'returns shortest distance' do
    seed_minimal_distances
    allow_any_instance_of(DijkstraService).to receive(:shortest_distance).and_return(50)

    expect(ShortestDistanceService.new('A', 'B').calculate).to eq 50
  end
end
