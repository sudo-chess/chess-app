class Game < ApplicationRecord


  ## Results of the game after the game is over enumerated within the result column
  enum result: {black_wins: 0, white_wins: 1, stalemate: 2}

  has_many	:pieces

  belongs_to :white_player, :class_name => 'User', :foreign_key => 'white_player_id'
  belongs_to :black_player, :class_name => 'User', :foreign_key => 'black_player_id', optional: true

  scope :pending,  ->{ where(black_player_id: nil)}
  scope :playing,  ->{ where.not(black_player_id: nil).where(result: nil)}
  scope :complete, ->{ where(winner_id: true).where.not(result: nil)}

  after_create :populate_game!

  def forfeit!(player)
    if player == white_player
      update!(:result => 0, :winner_id => black_player_id)
    elsif player == black_player
      update!(:result => 1, :winner_id => white_player_id)
    end
  end

  def name(player)
    if player == self.white_player_id
        User.find(self.black_player_id).email
    else
        User.find(self.white_player_id).email
    end
    
  end

  def next_player(player)

    if player == self.white_player_id
      self.update_attributes(next_player_id: self.black_player_id)
      self.reload
    else
      self.update_attributes(next_player_id: self.white_player_id)
       self.reload
    end
     
  end


  def is_stalemate?(color)
    game = self
    @squares = []
    numbers = [1,2,3,4,5,6,7,8]
    numbers.each do |x|
      numbers.each do |y|
        @squares << [x,y]
      end
    end

    king = game.pieces.where(type: "King", color: color)[0]
    allpieces = game.pieces.where("type != 'King'")
    pieces = allpieces.where(color: color)

    return false if king.is_in_check?
    
    pieces.each do |piece|
      @squares.each do |position|
        return false if piece.valid_move?(position[0], position[1])
      end
    end

    return false if king.escapable?

    return true
  end
  
  def player_in_check?(color)
     game = self
     king = game.pieces.find_by(type: "King", color: color)
     return king.is_in_check?
  end

  def player_checkmate?(color)
    game = self
    king = game.pieces.find_by(type: "King", color: color)
    return king.is_in_checkmate?
  end

  def populate_game!
    color = ""

    [2,7].each do |y|
      (1..8).each do |x|
        y == 2? color = "white" : color ="black"
        Pawn.create(game_id: id, position_x: x, position_y: y, color: color, :image => Pawn.get_image(color))
      end
    end

    [1,8].each do |y|
      [1,8].each do |x|
        y == 1? color = "white" : color ="black"
        Rook.create(game_id: id, position_x: x, position_y: y, color: color, :image => Rook.get_image(color))
      end
    end

     [1,8].each do |y|
      [2,7].each do |x|
        y == 1? color = "white" : color ="black"
          Knight.create(game_id: id, position_x: x, position_y: y, color: color, :image => Knight.get_image(color))
        end
      end

      [1,8].each do |y|
      [3,6].each do |x|
        y == 1? color = "white" : color ="black"
        Bishop.create(game_id: id, position_x: x, position_y: y, color: color, :image => Bishop.get_image(color))
      end
    end

      [1,8].each do |y|
        y == 1? color = "white" : color ="black"
        Queen.create(game_id: id, position_x: 4, position_y: y, color: color, :image => Queen.get_image(color))
      end

      [1,8].each do |y|
        y == 1? color = "white" : color ="black"
        King.create(game_id: id, position_x: 5, position_y: y, color: color, :image => King.get_image(color))
      end
  end

  # def populate_game!
  #   Pawn.create(game_id: id, position_x: 1, position_y: 7, color: "black", :image => Pawn.get_image("black"))
  #   Queen.create(game_id: id, position_x: 3, position_y: 8, color: "white", :image => Queen.get_image("white"))
  #   Queen.create(game_id: id, position_x: 3, position_y: 7, color: "white", :image => Queen.get_image("white"))

  #   King.create(game_id: id, position_x: 1, position_y: 8, color: "black", :image => King.get_image("black"))
  #   # Rook.create(game_id: id, position_x: 8, position_y: 8, color: "black", :image => Rook.get_image("black"))

  # end
end
