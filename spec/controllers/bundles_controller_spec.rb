require 'rails_helper'

RSpec.describe BundlesController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET #index" do
    it 'should require login' do
      get :index

      expect(response).to be_redirect
    end

    it 'should succeed with login' do
      user = create(:user)
      sign_in user
      get :index

      expect(response).to have_http_status(:success)


      user.destroy
    end
  end

  describe "POST #create" do
    before do
      user = create(:user)
      sign_in user
    end

    after do
      Bundle.destroy_all
      User.destroy_all
    end

    subject { post :create, params: params }

    let(:params) { { bundle: { title: 'my bundle', image: FilesTestHelper.jpg } } }

    context 'valid request' do
      it 'returns status created' do
        subject

        expect(response).to have_http_status :created
      end
    end
  end

  describe "get #bundle" do
    before do
      user = create(:user)
      sign_in user
      @bundle = create(:bundle, creator: user, image: FilesTestHelper.jpg)
    end

    context "with logged in request" do
      it 'should return a bundle' do
        get :show, params: {id: @bundle.id}
        p response.body
        expect(response).to have_http_status :success
      end
    end
  end
end
