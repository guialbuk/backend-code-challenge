require 'rails_helper'

describe 'POST /distance' do
  context 'creates Distance'
  it 'with valid data' do
    expect do
      post distance_path, params: 'A B 10'
    end.to change { Distance.count }.by 1

    expect(response).to have_http_status :ok
    expect(response.body).to eq 'OK'
  end

  context 'does not create Distance' do
    it 'with invalid origin, distance and length' do
      expect do
        post distance_path, params: 'a z 0'
      end.to_not change { Distance.count }

      expect(response).to have_http_status :unprocessable_entity

      expect(response.body).to eq 'Error
Origin only uppercase letters are accepted
Destination only uppercase letters are accepted
Length must be greater than 0'
    end
  end
end
