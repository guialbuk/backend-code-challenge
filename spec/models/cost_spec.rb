require 'rails_helper'

describe Cost do
  it { is_expected.to validate_presence_of :origin }
  it { is_expected.to validate_presence_of :destination }

  it do
    is_expected.to validate_numericality_of(:weight)
      .only_integer
      .is_greater_than(0)
      .is_less_than_or_equal_to(50)
  end

  it 'origin and destination must have only A-Z letters' do
    expect(build :cost, origin: 'AA').to be_valid
    expect(build :cost, origin: 'a').to be_invalid
    expect(build :cost, destination: 'z').to be_invalid
    expect(build :cost, origin: '1').to be_invalid
    expect(build :cost, origin: 'Ã').to be_invalid
  end

  it 'origin and destination must be different (case insensitive)' do
    expect(build :cost, origin: 'A', destination: 'A').to be_invalid
  end

  context 'calculates shipping cost' do
    it 'valid route' do
      allow_any_instance_of(ShortestDistanceService).to receive(:calculate).and_return(99)

      expect(build(:cost, weight: 10).calculate_shipping).to eq '148.50'
    end

    it 'invalid route' do
      allow_any_instance_of(ShortestDistanceService).to receive(:calculate).and_return(nil)

      expect(build(:cost).calculate_shipping).to eq nil
    end
  end

  it 'has a valid factory' do
    expect(build :cost).to be_valid
  end
end
