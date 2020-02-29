class BundleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :friendly_id

  attribute :created_at do |object|
    object.created_at.getutc.iso8601
  end

  attribute :image_url do |object|
    Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true) if object.image.try(:attached?)
  end
end
