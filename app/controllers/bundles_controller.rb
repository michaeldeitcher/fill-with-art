class BundlesController < ApplicationController
  # before_action :verify_user_is_logged_in

  def index
    render json: {}.as_json, status: :ok
  end

  def create
    bundle = Bundle.new(bundle_params)
    bundle.creator = current_user
    if bundle.save
      json = {
        data: {
          id: bundle.id,
          type: 'Bundle',
          attributes: bundle.attributes.slice('title')
        }
      }.to_json
      render json: json, status: :created
    else
      render json: { errors: ErrorSerializer.serialize(bundle) }, status: 422
    end
  end

  private

  def bundle_params
    params.require(:bundle).permit(:title, :image)
  end
end
