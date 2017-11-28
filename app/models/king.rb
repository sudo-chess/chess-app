class King < Piece
  name = "King"

  def self.get_image(color)
    if color == "white"
      return "chess_piece_king_white.png"
    elsif color == "black"
      return "chess_piece_king_black.png"
    end
  end

  def valid_move?(x,y)
    @current_x = self.position_x
    @current_y = self.position_y
    
    valid_moves = [
      [@current_x+1,@current_y+1], 
      [@current_x+1,@current_y], 
      [@current_x+1,@current_y-1], 
      [@current_x,@current_y+1], 
      [@current_x,@current_y-1], 
      [@current_x-1,@current_y+1], 
      [@current_x-1,@current_y], 
      [@current_x-1,@current_y-1]
    ]

    if valid_moves.include?([x,y]) && is_on_board?(x,y)
      return true
    else
      return false
    end
  end  
end


[@current_x+1,@current_y+1], 
[@current_x+1,@current_y], 
[@current_x+1,@current_y-1], 

[@current_x,@current_y+1], 
[@current_x,@current_y-1], 

[@current_x-1,@current_y+1], 
[@current_x-1,@current_y], 
[@current_x-1,@current_y-1]
