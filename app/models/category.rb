class Category < ApplicationRecord
  has_one_attached :icon

  has_many :transactions, dependent: :destroy

  validates_presence_of :name

  validates_uniqueness_of :name
end
