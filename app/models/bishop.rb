class Bishop < Piece

  def self.get_image(color)
    if color == "white"
      return "chess_piece_bishop_white.png"
    elsif color == "black"
      return "chess_piece_bishop_black.png"
    end
  end  


 def valid_move?(x,y)
     diagonal_move?(x,y) && is_on_board?(x,y) 
 end
 

 def diagonal_move?(x,y)
    @current_x = self.position_x
    @current_y = self.position_y

    (@current_x-x).abs == (@current_y-y).abs
  
  end

end
