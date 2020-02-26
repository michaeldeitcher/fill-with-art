class Bundle < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :bundle_sections
  has_one_attached :image

  validates :title, length: 3..20
  validates :image, presence: true
end
