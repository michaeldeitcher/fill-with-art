class BundlesController < ApplicationController
  before_action :verify_user_is_logged_in, only: [:index, :create]

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
    bundle = Bundle.includes(:bundle_contributions).friendly.find(params[:id])
    render json: BundleSerializer.new(bundle,{include: [:bundle_contributions]}).serialized_json
  end

  private

  def bundle_params
    params.require(:bundle).permit(:title, :image, :anonymous_token)
  end
end
