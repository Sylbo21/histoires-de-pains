class AddRoundToBatch < ActiveRecord::Migration[5.1]
  def change
    add_reference :batches, :round, foreign_key: true
  end
end
