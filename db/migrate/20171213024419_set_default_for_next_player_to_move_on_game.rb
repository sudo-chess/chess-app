class SetDefaultForNextPlayerToMoveOnGame < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :next_player_to_move_id
    add_column :games, :next_player_to_move_id, :integer, index: true, default: 0
  end
end
