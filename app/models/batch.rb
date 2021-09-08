class Batch < ApplicationRecord
  belongs_to :round

  validates :date, presence: true
  validates :date, uniqueness: true

  scope :next, -> { order(date: :asc).limit(6) }

end
