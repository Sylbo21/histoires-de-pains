class ChangeTimeToBeDateInBatches < ActiveRecord::Migration[5.1]
  def change
    change_column :batches, :date, :date
  end
end
