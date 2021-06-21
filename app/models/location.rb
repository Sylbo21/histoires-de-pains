class Location < ApplicationRecord
  has_and_belongs_to_many :rounds

  validates :name,    presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode
end
