class Bishop < Piece
  def self.get_image(color)
    if color == "white"
      return "chess_piece_bishop_white.png"
    elsif color == "black"
      return "chess_piece_bishop_black.png"
    end
  end  


 def valid_move?(x,y)
     diagonal_move?(x,y) && is_on_board?(x,y) && !is_obstructed?(self.game,[x,y])
 end
 

 def diagonal_move?(x,y)

    (position_x.to_i-x.to_i).abs == (position_y.to_i-y.to_i).abs
 end

end
