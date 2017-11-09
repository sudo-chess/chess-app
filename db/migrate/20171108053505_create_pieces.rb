class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.integer :piece_id
      t.integer :game_id
      t.string  :name
      t.string  :color
      t.integer :position_x
      t.integer :position_y
      t.timestamps
    end
  end
end
