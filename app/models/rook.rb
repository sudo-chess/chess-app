class Rook < Piece

  def self.get_image(color)
    if color == "white"
      return "chess_piece_rook_white.png"
    elsif color == "black"
      return "chess_piece_rook_black.png"
    end
  end  
end
