class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :game_id
      t.integer :white_player_id
      t.integer :black_player_id
      t.integer :result
      t.integer :winner_id
      t.integer :loser_id
      
      t.timestamps
    end
  end
end
