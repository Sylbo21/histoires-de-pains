class ChangeDatetimeToBeTimeInBatches < ActiveRecord::Migration[5.1]
  def change
    change_column :batches, :date, :time
  end
end
