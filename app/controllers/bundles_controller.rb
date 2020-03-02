class BundlesController < ApplicationController
  before_action :verify_user_is_logged_in

  def index
    bundles = current_user.bundles.order(updated_at: 'desc')
    render json: BundleSerializer.new(bundles).serialized_json, status: :ok
  end

  def create
    bundle = Bundle.new(bundle_params)
    bundle.creator = current_user
    if bundle.save
      render json: BundleSerializer.new(bundle).serialized_json, status: :created
    else
      render json: { errors: ErrorSerializer.serialize(bundle) }, status: 422
    end
  end

  def show
    bundle = current_user.bundles.friendly.find(params[:id])
    render json: BundleSerializer.new(bundle).serialized_json
  end

  private

  def bundle_params
    params.require(:bundle).permit(:title, :image)
  end
end
