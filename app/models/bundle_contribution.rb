class BundleContribution < ApplicationRecord
  belongs_to :bundle
  has_one_attached :image
  belongs_to :creator, class_name: 'User', optional: true

  validates :anonymous_token, presence: true
end
