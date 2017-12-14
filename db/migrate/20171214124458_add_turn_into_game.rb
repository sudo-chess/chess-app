class AddTurnIntoGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :next_player_id, :integer
  end
end
