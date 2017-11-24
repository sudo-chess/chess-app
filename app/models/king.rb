class King < Piece
  name = "King"

  def self.get_image(color)
    if color == "white"
      return "chess_piece_king_white.png"
    elsif color == "black"
      return "chess_piece_king_black.png"
    end
  end  
end
