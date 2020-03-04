class BundleContribution < ApplicationRecord
  belongs_to :bundle
  has_one_attached :image
  belongs_to :creator, class_name: 'User', optional: true

  validates :anonymous_token, presence: true
  validate :verify_new_anonymous_token
  validate :verify_text_or_image_present
  before_validation :assure_contribution_order

  def assure_contribution_order
    self.contribution_order = bundle.bundle_contributions.count if bundle
  end

  def last_contribution
    bundle.bundle_contributions.where(contribution_order: contribution_order - 1).limit(1).first
  end

  def verify_text_or_image_present
    unless(text.present? || image.present?)
      error = 'Text or image must be present'
      errors.add(:image, error)
      errors.add(:text, error)
    end
  end

  def verify_new_anonymous_token
    return unless bundle
    self.bundle.bundle_contributions.each {|o| p o}
    if (contribution_order == 0 &&
          bundle.anonymous_token == anonymous_token) ||
       (last_contribution.try(:anonymous_token) == anonymous_token)
      errors.add(:anonymous_token, 'Must be different from the last contribution.')
    end
  end
end
