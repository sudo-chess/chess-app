class Rook < Piece

  def self.get_image(color)
    if color == "white"
      return "chess_piece_rook_white.png"
    elsif color == "black"
      return "chess_piece_rook_black.png"
    end
  end

  def valid_move?(x,y)
    directional_move?(x,y) && is_on_board?(x,y) && !is_obstructed?(self.game,[x,y])
  end

  def directional_move?(x,y)
    self.position_x == x || self.position_y == y
  end

end
