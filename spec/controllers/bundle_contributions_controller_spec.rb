require 'rails_helper'

RSpec.describe BundleContributionsController, type: :controller do
  let(:user) { create(:user) }
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    let(:bundle) { create(:bundle, creator: user, anonymous_token: '123456') }
    let(:params) {
      { bundle_contribution:
        { bundle_id: bundle.friendly_id, text: 'hello', anonymous_token: '65321' }
      }
    }
    subject { post :create, params: params }

    it 'should create a bundle contribution' do
      expect{ subject }.to change { BundleContribution.count }.by(1)

      expect(response).to have_http_status 201
    end

    describe 'with missing params' do
      it 'should respond with errors' do
        post :create, params: {bundle_contribution: { bundle_id: bundle.friendly_id }}

        expect(response).to have_http_status 422
      end
    end
  end
end
