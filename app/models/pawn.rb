class Pawn < Piece
  def self.get_image(color)
    if color == "white"
      return "chess_piece_pawn_white.png"
    elsif color == "black"
      return "chess_piece_pawn_black.png"
    end
  end


  def valid_move?(x,y)
    @current_x = self.position_x
    @current_y = self.position_y
    @object = self.game.pieces.where(position_x: new_x, position_y: new_y)[0]

    valid_moves= []

    if self.color == "black"
      if @current_x == x && !@object
        valid_moves << [@current_x,@current_y+1]
        if self.moved == false && !@object
          valid_moves << [@current_x,@current_y+2]
        elsif @current_x == x-1 && @object.color == "white"
          valid_moves << [@current_x+1,@current_y+1]]
        elsif @current_x == x+1 && @object.color == "white"
          valid_moves << [@current_x-1,@current_y+1]]
        end
      end
    else
      if @current_x == x && !@object
        valid_moves << [@current_x,@current_y-1]
        if self.moved == false && !@object
          valid_moves << [@current_x,@current_y-2]
        elsif @current_x == x-1 && @object.color == "black"
          valid_moves << [@current_x+1,@current_y-1]]
        elsif @current_x == x+1 && @object.color == "black"
          valid_moves << [@current_x-1,@current_y-1]]
        end
      end
    end

    if valid_moves.include?([x,y]) && is_on_board?(x,y)
      return true
    else
      return false
    end
  end 

end
