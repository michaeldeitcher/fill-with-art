require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'when user is valid' do
      it 'renders a successful json resource' do
        user = build(:user)
        post :create, params: { user: { username: user.username, email: user.email,
                                        password: user.password } }

        expect(response).to have_http_status(:success)
        expect(User.last.email).to eq(user.email)
        json = JSON.parse(response.body)
        expected_json = {
          'data' => {
            'id' => User.last.id,
            'type' => 'User',
            'attributes' => {
                'authentication_token' => User.last.authentication_token,
                'username' => user.username,
                'email' => user.email
            }
          }
        }
        expect(json).to match(expected_json)
      end
    end

    context 'when password is invalid' do
      it 'renders a successful json resource' do
        user = build(:user)
        post :create, params: { user: { username: user.username, email: user.email,
                                        password: '' } }

        expect(response).to have_http_status(422)
        json = JSON.parse(response.body)
        expected_json = {
          'errors' => [{
            'status' => 422,
            'source' => {'pointer' => '/data/attributes/password'},
            'detail' => "can't be blank"
          }]
        }
        expect(json).to match(expected_json)
      end
    end

  end
end
