require 'rails_helper'

describe Distance do
  it 'has a valid factory' do
    expect(build :distance).to be_valid
  end
end
