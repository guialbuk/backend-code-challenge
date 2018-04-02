require 'rails_helper'

describe 'POST /distance' do
  context 'creates Distance'
  it 'with valid data' do
    expect do
      post distance_path, params: 'AA BB 10'
    end.to change { Distance.count }.by 1

    expect(response).to have_http_status :ok
    expect(response.body).to eq 'OK'
  end

  it 'with valid data - not sorted' do
    expect do
      post distance_path, params: 'B A 10'
    end.to change { Distance.count }.by 1

    expect(response).to have_http_status :ok
    expect(response.body).to eq 'OK'

    record = Distance.last
    expect(record.origin).to eq 'A'
    expect(record.destination).to eq 'B'
  end

  context 'does not create Distance' do
    it 'with invalid origin, distance and length' do
      expect do
        post distance_path, params: 'a z 0'
      end.to_not change { Distance.count }

      expect(response).to have_http_status :unprocessable_entity

      expect(response.body).to eq 'Error
Origin must have only uppercase letters and no accents
Destination must have only uppercase letters and no accents
Length must be greater than 0'
    end

    it 'with invalid format - missing space' do
      expect do
        post distance_path, params: 'AZ 1'
      end.to_not change { Distance.count }

      expect(response).to have_http_status :unprocessable_entity
    end

    it 'with invalid format - swapped positions' do
      expect do
        post distance_path, params: 'A 10 Z'
      end.to_not change { Distance.count }

      expect(response).to have_http_status :unprocessable_entity
    end

    it 'with invalid format - no spaces' do
      expect do
        post distance_path, params: 'AZ1'
      end.to_not change { Distance.count }

      expect(response).to have_http_status :unprocessable_entity
    end

    it 'with blank data' do
      expect { post distance_path, params: '' }.to_not change { Distance.count }

      expect(response).to have_http_status :unprocessable_entity
    end

    it 'without data' do
      expect { post distance_path }.to_not change { Distance.count }

      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
