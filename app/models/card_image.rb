class CardImage < ApplicationRecord
  has_many :credit_card_images, dependent: :destroy

  has_one_attached :image

  validates_uniqueness_of :name

  BLANK_TEMPLATE_NAME = 'blank'.freeze

  def self.blank_card
    CardImage.find_by(name: BLANK_TEMPLATE_NAME)
  end

  def blank?
    name == BLANK_TEMPLATE_NAME
  end
end
