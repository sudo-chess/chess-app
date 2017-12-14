class AlterGames < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :next_player_to_move_id, :integer, index: true, default: 0
    add_column :games, :next_player_to_move_id, :integer, index: true, default: :white_player_id
  end
end


