class AddTurnToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :next_player_to_move_id, :integer, index: true
  end
end
