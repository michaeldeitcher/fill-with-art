class BundleContributionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :text, :contribution_order, :anonymous_token

  attribute :created_at do |object|
    object.created_at.getutc.iso8601
  end

  attribute :image_url do |object|
    Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true) if object.image.try(:attached?)
  end
end
