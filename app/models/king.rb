class King < Piece
  def self.get_image(color)
    if color == "white"
      return "chess_piece_king_white.png"
    elsif color == "black"
      return "chess_piece_king_black.png"
    end
  end

 def valid_move?(x,y)
    
    if !self.moved && self.game.pieces.where(position_x: 6, position_y: self.position_y)[0] == nil && self.game.pieces.where(position_x: 4, position_y: self.position_y)[0] == nil
      castle_right = [self.position_x+2,self.position_y]
      castle_left = [self.position_x-2,self.position_y]
    elsif !self.moved && self.game.pieces.where(position_x: 6, position_y: self.position_y)[0] == nil
      castle_right = [self.position_x+2,self.position_y]
      castle_left = [self.position_x+1,self.position_y+1]
    elsif !self.moved && self.game.pieces.where(position_x: 4, position_y: self.position_y)[0] == nil && self.game.pieces.where(position_x: 2, position_y: self.position_y)[0] == nil
      castle_right = [self.position_x+1,self.position_y+1]
      castle_left = [self.position_x-2,self.position_y]
    else
      castle_right = [self.position_x+1,self.position_y+1]
      castle_left = [self.position_x+1,self.position_y+1]
    end


    valid_moves = [castle_right, castle_left,
      [self.position_x+1,self.position_y+1],
      [self.position_x+1,self.position_y],
      [self.position_x+1,self.position_y-1],
      [self.position_x,self.position_y+1],
      [self.position_x,self.position_y-1],
      [self.position_x-1,self.position_y+1],
      [self.position_x-1,self.position_y],
      [self.position_x-1,self.position_y-1]
    ]

    return valid_moves.include?([x,y]) && is_on_board?(x,y) 
  end


  def castle!(side, color)
    if color == "white"
      white_king            = self.game.pieces.where(position_x: 5, position_y: 1)[0]
      white_kingside_rook   = self.game.pieces.where(position_x: 8, position_y: 1)[0]
      white_queenside_rook  = self.game.pieces.where(position_x: 1, position_y: 1)[0]
      if side == "kingside_castle"
        white_king.update_attributes(position_x: 7, position_y: 1, moved: true)
        white_kingside_rook.update_attributes!(position_x: 6, position_y: 1, moved: true)
        game.reload
      elsif side == "queenside_castle"
        white_king.update_attributes(position_x: 3, position_y: 1, moved: true)
        white_queenside_rook.update_attributes(position_x: 4, position_y: 1, moved: true)
        game.reload
      end
    elsif color == "black"
      black_king            = self.game.pieces.where(position_x: 5, position_y: 8)[0]
      black_kingside_rook   = self.game.pieces.where(position_x: 8, position_y: 8)[0]
      black_queenside_rook  = self.game.pieces.where(position_x: 1, position_y: 8)[0]
      if side == "kingside_castle"
        black_king.update_attributes(position_x: 7, position_y: 8, moved: true)
        black_kingside_rook.update_attributes(position_x: 6, position_y: 8, moved: true)
        game.reload
      elsif side == "queenside_castle"
        black_king.update_attributes(position_x: 3, position_y: 8, moved: true)
        black_queenside_rook.update_attributes(position_x: 4, position_y: 8, moved: true)
        game.reload
      end
    end
  end

  def can_castle

    available_moves = []
    game.pieces.each do |piece|
      if piece.type == "Rook" && piece.moved == false
        kingside_rook     = self.game.pieces.where(position_x: 1, position_y: piece.position_y)[0]
        kingside_knight   = self.game.pieces.where(position_x: 2, position_y: piece.position_y)[0]
        kingside_bishop   = self.game.pieces.where(position_x: 3, position_y: piece.position_y)[0]
        king              = self.game.pieces.where(type: "King", color: self.color)[0] 

        queen             = self.game.pieces.where(position_x: 4, position_y: piece.position_y)[0]
        queenside_bishop  = self.game.pieces.where(position_x: 6, position_y: piece.position_y)[0]
        queenside_knight  = self.game.pieces.where(position_x: 7, position_y: piece.position_y)[0]
        queenside_rook    = self.game.pieces.where(position_x: 8, position_y: piece.position_y)[0]
        if king.moved == false && king.is_in_check? == false
          if piece == kingside_rook && kingside_knight == nil && kingside_bishop == nil
            if king.is_in_check?(6, piece.position_y) == false && king.is_in_check?(7, piece.position_y) == false
              available_moves << ["kingside_castle", piece.color]
            end
          elsif piece == queenside_rook && queen == nil && queenside_bishop == nil && queenside_knight == nil
            if king.is_in_check?(3, piece.position_y) == false && king.is_in_check?(4, piece.position_y) == false
              available_moves << ["queenside_castle", piece.color]
            end
          end
        end
      end
    end
    available_moves
  end

end
