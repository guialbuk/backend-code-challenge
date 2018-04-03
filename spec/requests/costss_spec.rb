require 'rails_helper'

describe 'GET /cost' do
  context 'retrieve shipping cost'
  it 'with valid data' do
    seed_minimal_distances
    allow_any_instance_of(ShortestDistanceService).to receive(:calculate).and_return(50)

    get cost_path, params: attributes_for(:cost, origin: 'A', destination: 'C', weight: 5)

    expect(response).to have_http_status :ok
    expect(response.body).to eq '37.50'
  end

  context 'does not create Distance' do
    it 'with invalid origin, distance and length' do
      expect do
        get cost_path, params: attributes_for(:cost, origin: 'a', destination: 'z', weight: 0)
      end.to_not change { Distance.count }

      expect(response).to have_http_status :unprocessable_entity

      expect(response.body).to eq 'Error
Origin must have only uppercase letters and no accents
Destination must have only uppercase letters and no accents
Weight must be greater than 0'
    end

    it 'with blank data' do
      get cost_path, params: attributes_for(:cost, origin: '', destination: '', weight: '')

      expect(response).to have_http_status :unprocessable_entity
      expect(response.body).to match 'Error'
    end

    it 'without data' do
      get cost_path

      expect(response).to have_http_status :unprocessable_entity
      expect(response.body).to match 'Error'
    end
  end
end
