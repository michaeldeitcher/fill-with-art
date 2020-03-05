class BundleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :friendly_id

  has_many :bundle_contributions, serializer: BundleContributionSerializer

  attribute :created_at do |object|
    object.created_at.getutc.iso8601
  end

  attribute :image_url do |object|
    Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true) if object.image.try(:attached?)
  end

  attribute :last_anonymous_token_contribution do |object|
    last_contribution = object.bundle_contributions.last || object
    last_contribution.anonymous_token
  end
end
