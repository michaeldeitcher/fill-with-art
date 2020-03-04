class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user_from_token!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!

  protected
  def verify_user_is_logged_in
    if current_user
      true
    else
      render json: {message: 'Sorry, not found.'}, status: :not_found
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      user       = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.authentication_token, token)
        sign_in user, store: false
      end
    end
  end

  def render_unauthorized
    render json: { message: 'you are not authorized' }, status: :unauthorized
    false
  end
end
