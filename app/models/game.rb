class Game < ApplicationRecord
  has_many	:pieces

  belongs_to :white_player, :class_name => 'User', :foreign_key => 'white_player_id'
  belongs_to :black_player, :class_name => 'User', :foreign_key => 'black_player_id', optional: true

  scope :pending,  ->{ where(black_player_id: nil)}
  scope :playing,  ->{ where.not(black_player_id: nil).where(result: nil)}
  scope :complete, ->{ where(winner_id: true)}

  after_create :populate_game!


  def populate_game!
    color = ""
   
    [2,7].each do |y|
      (1..8).each do |x|
        y == 2? color = "white" : color ="black"
        Pawn.create(game_id: id, position_x: x, position_y: y, color: color)
      end
    end

    [1,8].each do |y|
      [1,8].each do |x|
        y == 1? color = "white" : color ="black"
        Rook.create(game_id: id, position_x: x, position_y: y, color: color)
      end
    end

     [1,8].each do |y|
      [2,7].each do |x|
        y == 1? color = "white" : color ="black"
        Knight.create(game_id: id, position_x: x, position_y: y, color: color)
      end
    end

      [1,8].each do |y|
      [3,6].each do |x|
        y == 1? color = "white" : color ="black"
        Bishop.create(game_id: id, position_x: x, position_y: y, color: color)
      end
    end

      [1,8].each do |y|
        y == 1? color = "white" : color ="black"
        Queen.create(game_id: id, position_x: 4, position_y: y, color: color)
      end
    
      [1,8].each do |y|
        y == 1? color = "white" : color ="black"
        King.create(game_id: id, position_x: 4, position_y: y, color: color)
      end
  end
end
