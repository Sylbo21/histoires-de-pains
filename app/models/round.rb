class Round < ApplicationRecord
  has_and_belongs_to_many :locations
  has_many :batches

  validates :day, inclusion: { in: %w(Lundi Mardi Mercredi Jeudi Vendredi Samedi Dimanche) }
  
end
