require 'rails_helper'

RSpec.describe Bundle, type: :model do
  before{ @bundle = build(:bundle) }

  it 'should be valid' do
    expect(@bundle).to be_valid
  end

  it 'without creator should not be valid' do
    @bundle.creator = nil
    expect(@bundle).to_not be_valid
  end

  it 'without title should not be valid' do
    @bundle.title = nil
    expect(@bundle).to_not be_valid
  end

  it 'without image should not be valid' do
    @bundle.image = nil
    expect(@bundle).to_not be_valid
  end
end
