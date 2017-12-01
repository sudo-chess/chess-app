class Pawn < Piece
  def self.get_image(color)
    if color == "white"
      return "chess_piece_pawn_white.png"
    elsif color == "black"
      return "chess_piece_pawn_black.png"
    end
  end

  def valid_move?(x,y)
    @object = self.game.pieces.where(position_x: x, position_y: y)[0]
    # could we replace this with !occupied_positions ?
    valid_moves = []

    if self.color == "black"
      if self.position_x == x && self.position_y == y+1 && !@object 
        valid_moves << [self.position_x,self.position_y-1]
      elsif self.moved == false && !@object && !is_obstructed?(self.game,[x,y])
        valid_moves << [self.position_x,self.position_y-2]
      elsif self.position_x == x-1 && self.position_y == y+1 && @object.color == "white"
        valid_moves << [self.position_x+1,self.position_y-1]
      elsif self.position_x == x+1 && self.position_y == y+1 && @object.color == "white"
        valid_moves << [self.position_x-1,self.position_y-1]
      end
    else
      if self.position_x == x && self.position_y == y-1 && !@object 
        valid_moves << [self.position_x,self.position_y+1]
      elsif self.moved == false && !@object && !is_obstructed?(self.game,[x,y])
        valid_moves << [self.position_x,self.position_y+2]
      elsif self.position_x == x-1 && self.position_y == y-1 && @object.color == "black"
        valid_moves << [self.position_x+1,self.position_y+1]
      elsif self.position_x == x+1 && self.position_y == y-1 && @object.color == "black"
        valid_moves << [self.position_x-1,self.position_y+1]
      end
    end
    valid_moves.include?([x,y]) && is_on_board?(x,y)
  end
end
