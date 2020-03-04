require 'rails_helper'

RSpec.describe AnonymousTokensController, type: :controller do
  describe "GET #index" do
    it 'should return an anonymous id' do
      get :index
      content = JSON.parse(response.body)
      expect(content['token']).to be_present
      expect(response).to have_http_status :success
    end
  end
end
