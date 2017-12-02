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
    valid_moves = [
      [self.position_x+1,self.position_y+1], 
      [self.position_x+1,self.position_y], 
      [self.position_x+1,self.position_y-1], 
      [self.position_x,self.position_y+1], 
      [self.position_x,self.position_y-1], 
      [self.position_x-1,self.position_y+1], 
      [self.position_x-1,self.position_y], 
      [self.position_x-1,self.position_y-1]
    ]

    return valid_moves.include?([x,y])
  end  

  def castling(x,y)
    a_castling = [[@current_x+2,@current_y]] # black or queenside white
    b_castling = [[@current_x-2,@current_y]] # white or queenside black

    #should allow castling
    #cannot castle if your king has ever moved
    #cannot castle with a rook that has ever moved
    #cannot castle when your king is in check
    #cannot castle into check
    #cannot castle though check (?)
    #http://www.kidchess.com/wp_support_content/instruction/castling.htm
    
    # 1 check if king has been moved, check if rook has been moved, 
    # 2 check if king is in check, will pass though a check, or will be put in check
    # 3 depending if black or white king push correct castling array to vaild_moves 
    # maybe check if king is white or black at step 2 and run the three positions though check method, then allow castling
  end

  def check(x,y)
    #should restrict movement if in check
    #trigger checkmate or winner/loser
  end

end