class Queen < Piece
  name = "Queen"

  def self.get_image(color)
    if color == "white"
      return "chess_piece_queen_white.png"
    elsif color == "black"
      return "chess_piece_queen_black.png"
    end
  end  
end
