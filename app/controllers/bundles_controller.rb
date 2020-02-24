class BundlesController < ApplicationController
  before_action :verify_user_is_logged_in

  def index
    render json: {}.as_json, status: :ok
  end
end
