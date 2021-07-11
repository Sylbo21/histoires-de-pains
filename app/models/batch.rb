class Batch < ApplicationRecord
  belongs_to :round

  validates :date,  presence: true
end
