class CreateJoinTableLocationRound < ActiveRecord::Migration[5.1]
  def change
    create_join_table :locations, :rounds do |t|
      # t.index [:location_id, :round_id]
      # t.index [:round_id, :location_id]
    end
  end
end
