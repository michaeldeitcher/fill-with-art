class BundleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title

  attribute :created_at do |object|
    object.created_at.getutc.iso8601
  end

  attribute :image_url do |object|
    Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true) if object.image.attached?
  end

  attribute :path do |object|
    "/bundle/#{object.title}-#{object.id}"
  end
end
