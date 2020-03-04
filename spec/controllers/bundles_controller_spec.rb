require 'rails_helper'

RSpec.describe BundlesController, type: :controller do
  let(:user) { create(:user) }
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET #index" do
    let(:bundles) {(0..2).map &->(x){create(:bundle, :with_contributions, creator: user)}}

    it 'should require login' do
      get :index
      expect(response).to have_http_status(:not_found)
    end

    it 'should succeed with login' do
      sign_in user
      bundles
      get :index
      content = JSON.parse(response.body)
      expect(content['data'].length).to be(bundles.length)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:params) { { bundle: { title: 'my bundle', image: FilesTestHelper.jpg, anonymous_token: "123456" } } }
    subject { post :create, params: params }

    it "requires sign in" do
      expect { subject }.to change { Bundle.count }.by(0)

      expect(response).to have_http_status :not_found
    end

    context "signed in" do
      before { sign_in user }

      context 'valid request' do
        it 'returns status created' do
          expect { subject }.to change { Bundle.count }.by(1)

          expect(response).to have_http_status :created
        end
      end
      after {Bundle.destroy_all}
    end
  end

  describe "get #bundle" do
    context "with basic bundle" do
      let(:bundle) {create(:bundle, creator: user)}
      it 'should return a bundle' do
        get :show, params: {id: bundle.friendly_id}
        expect(response).to have_http_status :success
      end
    end

    context "with bundle with contributions" do
      let(:bundle) {create(:bundle, :with_contributions, creator: user)}
      it 'should return a bundle' do
        get :show, params: {id: bundle.friendly_id}
        content =  JSON.parse(response.body)
        expect(content['data']['relationships']['bundle_contributions']['data'].length).to be(2)
        expect(response).to have_http_status :success
      end
    end
  end
end
