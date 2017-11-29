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
    @current_x = self.position_x
    @current_y = self.position_y

    (@current_x-x).abs == (@current_y-y).abs
  
  end

def vertical_move?(x,y)
  @current_x = self.position_x
  @current_y = self.position_y

  ((@current_x == x) || (@current_y) == x)
end



end
