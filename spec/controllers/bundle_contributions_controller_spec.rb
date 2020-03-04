require 'rails_helper'

RSpec.describe BundleContributionsController, type: :controller do
  let(:user) { create(:user) }
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "POST #create" do
    let(:bundle) { create(:bundle, creator: user, anonymous_token: '123456') }
    let(:params) {
      { bundle_contribution:
        { bundle_id: bundle.friendly_id, anonymous_token: '123456' }
      }
    }
    subject { post :create, params: params }

    it "should create a bundle contribution" do
      subject
      p response.body
      expect(response).to have_http_status 201
    end
  end
end
