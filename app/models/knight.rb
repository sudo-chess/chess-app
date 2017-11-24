class Knight < Piece

  name = "Knight"  

  def self.get_image(color)
    if color == "white"
      return "chess_piece_knight_white.png"
    elsif color == "black"
      return "chess_piece_knight_black.png"
    end
  end  
end
