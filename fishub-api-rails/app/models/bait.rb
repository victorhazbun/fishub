class Bait < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :category, :image, presence: true
end
