class AddBlackplayerIdAndWhiteplayerIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :white_player
    add_reference :users, :black_player

    add_foreign_key :users, :games, column: :white_player_id
    add_foreign_key :users, :games, column: :black_player_id
  end
end
