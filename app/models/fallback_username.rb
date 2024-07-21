class FallbackUsername < ApplicationRecord
  validates :username, presence: true, format: { with: /\A[A-Z]{3}\z/ }
end
