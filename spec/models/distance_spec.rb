require 'rails_helper'

describe Distance do
  it { is_expected.to validate_presence_of :origin }
  it { is_expected.to validate_presence_of :destination }

  it do
    is_expected.to validate_numericality_of(:length)
      .only_integer
      .is_greater_than(0)
      .is_less_than_or_equal_to(100000)
  end

  it 'origin and destination must have only A-Z letters' do
    expect(build :distance, origin: 'a').to be_invalid
    expect(build :distance, destination: 'z').to be_invalid
    expect(build :distance, origin: '1').to be_invalid
    expect(build :distance, origin: 'Ã').to be_invalid
  end

  it 'origin and destination must be different (case insensitive)' do
    expect(build :distance, origin: 'A', destination: 'A').to be_invalid
  end

  it 'origin and destination must be sorted' do
    expect(build :distance, origin: 'Z', destination: 'A').to be_invalid
  end

  it 'creates a new record if no matching record is found' do
    create :distance, origin: 'A', destination: 'Z'

    expect do
      Distance.new(origin: 'B', destination: 'Z', length: 10).update_or_create
    end.to change { Distance.count }.by 1
  end

  it 'updates record if a matching record is found' do
    create :distance, origin: 'A', destination: 'Z', length: 9

    expect do
      Distance.new(origin: 'A', destination: 'Z', length: 10).update_or_create
    end.to_not change { Distance.count }

    expect(Distance.last.length).to eq 10
  end

  it 'has a valid factory' do
    expect(build :distance).to be_valid
  end
end
