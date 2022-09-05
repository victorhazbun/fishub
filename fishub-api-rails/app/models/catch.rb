class Catch < ApplicationRecord
  belongs_to :bait
  belongs_to :user

  validates :species, presence: true

  validates :weight, :length, 
            numericality: { greater_than: 0 },
            presence: true

  default_scope { order(created_at: :desc) }
end
