class Queen < Piece
  name = "Queen"

  def self.get_image(color)
    if color == "white"
      return "chess_piece_queen_white.png"
    elsif color == "black"
      return "chess_piece_queen_black.png"
    end
  end  

 def valid_move?(x,y)
    if (diagonal_move?(x,y) || vertical_move?(x,y)) && is_on_board?(x,y) 
      return true
    else
      return false
    end
  end

 def diagonal_move?(x,y)
    (self.position_x-x).abs == (self.position_y-y).abs
 end

 def vertical_move?(x,y)
    self.position_x == x || self.position_y == x
 end
end
