class Batch < ApplicationRecord
  belongs_to :round

  validates :date, presence: true
  validates :date, uniqueness: true

  scope :future,         -> { where('date > ?', Date.today) }
  scope :chronological,  -> { order(date: :asc) }
  scope :next_ones,      -> { future.chronological }
  scope :very_next_ones, -> { next_ones.limit(3) }

end
