class Rook < Piece

  def self.get_image(color)
    if color == "white"
      return "chess_piece_rook_white.png"
    elsif color == "black"
      return "chess_piece_rook_black.png"
    end
  end

  def on_axis?(x,y)

  def valid_move?(x,y)
    @current_x = self.position_x
    @current_y = self.position_y

    if x == @current_x || y == @current_y
      return true
    else
      return false
    end
  end 
end
