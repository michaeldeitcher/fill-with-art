class RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      json = {
        data: {
          id: resource.id,
          type: 'User',
          attributes: resource.attributes.slice('username', 'email', 'authentication_token')
        }
      }.to_json
      render json: json, status: 201
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: { errors: ErrorSerializer.serialize(resource) }, status: 422
    end
  end

  private

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end
end