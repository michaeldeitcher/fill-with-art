require 'rails_helper'

RSpec.describe BundleContribution, type: :model do
  let(:first_user) { create(:user) }
  let(:bundle) { create(:bundle) }
  let(:first_contribution) { build(:bundle_contribution, bundle: bundle) }

  context 'on first contribution' do
    it 'should be valid' do
      expect(first_contribution).to be_valid
    end

    it 'should require a bundle' do
      first_contribution.bundle = nil
      expect(first_contribution).to_not be_valid
    end

    it 'should require an image or text' do
      first_contribution.text = nil
      first_contribution.image = nil
      expect(first_contribution).to_not be_valid
    end

    it 'should be assigned a contribution_order' do
      expect(first_contribution).to be_valid
      expect(first_contribution.contribution_order).to be(0)
    end

    it 'should require a new token' do
      first_contribution.anonymous_token = nil
      expect(first_contribution).to_not be_valid
    end

    it 'should require a different token than the bundle' do
      first_contribution.anonymous_token = first_contribution.bundle.anonymous_token
      expect(first_contribution).to_not be_valid
    end

    it 'should update the updated at of the bundle' do
      expect{ first_contribution.save! }.to change {bundle.updated_at}
    end
  end

  context 'on second contribution' do
    before { first_contribution.save! }
    let(:second_contribution) { build(:bundle_contribution, bundle: bundle) }

    it 'should be valid' do
      expect(second_contribution).to be_valid
    end

    it 'should be assigned a contribution_order' do
      expect(second_contribution).to be_valid
      expect(second_contribution.contribution_order).to be(1)
    end

    it 'should require a different token than the first' do
      second_contribution.anonymous_token = first_contribution.anonymous_token;

      expect(second_contribution).to_not be_valid
    end
  end
end
