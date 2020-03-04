require 'rails_helper'

RSpec.describe BundleContribution, type: :model do
  subject { build(:bundle_contribution, { bundle: build(:bundle) }) }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should require a bundle' do
    subject.bundle = nil
    expect(subject).to_not be_valid
  end
end
