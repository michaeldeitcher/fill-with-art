class Bundle < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def slug_candidates() [[:creator_name, :title]] end
  def creator_name() creator.try(:username) end

  belongs_to :creator, class_name: 'User'
  has_many :bundle_sections
  has_one_attached :image

  validates :title, length: 3..20
  validates :image, presence: true
end
