class Round < ApplicationRecord
  validates :day, inclusion: { in: %w(Lundi Mardi Mercredi Jeudi Vendredi Samedi Dimanche) }
end
