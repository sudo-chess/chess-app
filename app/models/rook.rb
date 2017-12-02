class Rook < Piece
  def self.get_image(color)
    if color == 'white'
      'chess_piece_rook_white.png'
    elsif color == 'black'
      'chess_piece_rook_black.png'
    end
  end

  def valid_move?(x, y)
    (axis_move?(x, y) && is_on_board?(x,y) && !is_obstructed?(game, [x, y]))
  end

  def axis_move?(x, y)
    self.position_x.to_i == x.to_i || self.position_y.to_i == y.to_i  
  end
end
