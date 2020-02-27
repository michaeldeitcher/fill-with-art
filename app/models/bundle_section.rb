class BundleSection < ApplicationRecord
  belongs_to :bundle
  has_one_attached :image
end
