class Rook < Piece
  def self.get_image(color)
    if color == 'white'
      'chess_piece_rook_white.png'
    elsif color == 'black'
      'chess_piece_rook_black.png'
    end
  end

  def valid_move?(x, y)
    (vertical_move?(x, y) && !is_obstructed?(game, [x, y]))
  end

  def vertical_move?(x, y)
    position_x == x || position_y == y
  end
end
