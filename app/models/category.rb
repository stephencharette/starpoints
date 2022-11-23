class Category < ApplicationRecord
  has_one_attached :icon

  validates_presence_of :name

  validates_uniqueness_of :name
end
