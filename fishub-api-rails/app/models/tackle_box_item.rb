class TackleBoxItem < ApplicationRecord
  belongs_to :bait
  belongs_to :user

  default_scope { order(created_at: :desc) }
end
