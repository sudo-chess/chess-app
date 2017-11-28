class Bishop < Piece

  def self.get_image(color)
    if color == "white"
      return "chess_piece_bishop_white.png"
    elsif color == "black"
      return "chess_piece_bishop_black.png"
    end
  end  
end
