class Batch < ApplicationRecord
  belongs_to :round

  validates :date, presence: true
  validates :date, uniqueness: true
end
