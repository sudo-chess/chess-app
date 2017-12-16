class Knight < Piece
  def self.get_image(color)
    if color == "white"
      return "chess_piece_knight_white.png"
    elsif color == "black"
      return "chess_piece_knight_black.png"
    end
  end  

  def valid_move?(x,y)
    valid_moves = [
      [self.position_x+1,self.position_y+2], 
      [self.position_x+2,self.position_y+1], 
      [self.position_x+2,self.position_y-1], 
      [self.position_x+1,self.position_y-2], 
      [self.position_x-1,self.position_y-2], 
      [self.position_x-2,self.position_y-1], 
      [self.position_x-2,self.position_y+1], 
      [self.position_x-1,self.position_y+2]]
   
    return valid_moves.include?([x,y]) && is_on_board?(x,y)
  end

end
