class Pawn < Piece
  
  def self.get_image(color)
    if color == "white"
      return "chess_piece_pawn_white.png"
    elsif color == "black"
      return "chess_piece_pawn_black.png"
    end
  end
end
