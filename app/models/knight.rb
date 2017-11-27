class Knight < Piece

  

  def self.get_image(color)
    if color == "white"
      return "chess_piece_knight_white.png"
    elsif color == "black"
      return "chess_piece_knight_black.png"
    end
  end  


def valid_move?(x,y)
  @current_x = self.position_x
  @current_y = self.position_y
 
  valid_moves = [[@current_x+1,@current_y+2], [@current_x+2,@current_y+1], [@current_x+2,@current_y-1], [@current_x+1,@current_y-2], [@current_x-1,@current_y-2], [@current_x-2,@current_y-1], [@current_x-2,@current_y+1], [@current_x-1,@current_y+2]]
 
  if valid_moves.include?([x,y]) && is_on_board?(x,y)
    return true
  else
    return false
  end
 
   end

end
