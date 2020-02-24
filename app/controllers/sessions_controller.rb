class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    json = {
      data: {
        id: resource.id, type: 'User',
        attributes: resource.attributes.slice('username', 'email', 'authentication_token')
      }
    }.to_json
    render json: json, status: 201
  end
end