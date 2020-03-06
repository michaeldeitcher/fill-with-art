class BundleContributionsController < ApplicationController
  def create
    bundle = Bundle.friendly.find(params[:bundle_contribution][:bundle_id])
    bundle_contribution = BundleContribution.new(bundle_contribution_params)
    bundle_contribution.bundle = bundle
    bundle_contribution.creator = current_user
    if bundle_contribution.save
      serialized_data = BundleContributionSerializer.new(bundle_contribution).serialized_json
      BundleContributionsChannel.broadcast_to bundle, serialized_data
      render json: serialized_data, status: :created
    else
      render json: { errors: ErrorSerializer.serialize(bundle_contribution) }, status: 422
    end
  end

  private

  def bundle_contribution_params
    params.require(:bundle_contribution).permit(:text, :image, :anonymous_token)
  end
end
