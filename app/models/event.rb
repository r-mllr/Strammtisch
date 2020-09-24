class Event < ApplicationRecord
  has_and_belongs_to_many :users

  validates :takes_place_at, presence: true
  
  scope :upcoming, -> { 
    now = Time.zone.now
    where("takes_place_at >= ?", now) 
  }
  scope :past, -> {
    now = Time.zone.now
    where("takes_place_at < ?", now)
  }
end
