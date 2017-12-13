class SetDefaultForNextPlayerToMoveOnGame < ActiveRecord::Migration[5.0]
  def change
    change_column_default games: :next_player_to_move_id, default: 0
  end
end
