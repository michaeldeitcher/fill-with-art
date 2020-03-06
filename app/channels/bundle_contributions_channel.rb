class BundleContributionsChannel < ApplicationCable::Channel
  def subscribed
    bundle = Bundle.friendly.find(params[:bundle])
    stream_for bundle
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
