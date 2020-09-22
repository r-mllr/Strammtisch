class Event < ApplicationRecord
  validates :takes_place_at, presence: true
end
