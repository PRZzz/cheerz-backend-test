class FallbackUsername < ApplicationRecord
  validates :username, presence: true
end