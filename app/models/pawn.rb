class Pawn < Piece
  def self.get_image(color)
    if color == "white"
      return "chess_piece_pawn_white.png"
    elsif color == "black"
      return "chess_piece_pawn_black.png"
    end
  end

  def can_capture?(x,y, color)

    piece_on_target = self.game.pieces.where(position_x: x, position_y: y)[0]
    if piece_on_target != nil
      if color != piece_on_target.color
        return true
      end
    end
    if color == 'white'
      if self.game.pieces.where(position_x: x, position_y: y-1)[0] != nil
        if self.game.pieces.where(position_x: x, position_y: y-1)[0].en_passant == true 
          return true
        end
      end
    elsif color == 'black'
      if self.game.pieces.where(position_x: x, position_y: y+1)[0] != nil
        if self.game.pieces.where(position_x: x, position_y: y+1)[0].en_passant == true
          return true
        end
      end
    end
      return false
  end


  def promotion(x,y,promo) 
    game = self.game
    self.update_attributes(position_x: nil, position_y: nil)
    if promo == "Queen"
      Queen.create(game_id: game.id, position_x: x, position_y: y, color: self.color, :image => Queen.get_image(color))
    elsif promo == "Rook"
      Rook.create(game_id: game.id, position_x: x, position_y: y, color: self.color, :image => Rook.get_image(color))
    elsif promo == "Bishop"
      Bishop.create(game_id: game.id, position_x: x, position_y: y, color: self.color, :image => Bishop.get_image(color))
    elsif promo == "Knight"
      Knight.create(game_id: game.id, position_x: x, position_y: y, color: self.color, :image => Knight.get_image(color))
    elsif promo == "" || promo == nil
      Pawn.create(game_id: game.id, position_x: x, position_y: y, color: self.color, :image => Pawn.get_image(color))
    end

  end


  def valid_move?(x,y)
    x = x
    y = y

    piece_on_target = self.game.pieces.where(position_x: x, position_y: y)[0]
    valid_moves = []

    if is_on_board?(x,y)
      if self.color == "black"
        if self.position_x == x && self.position_y == y+1 && !piece_on_target 
          valid_moves << [self.position_x,self.position_y-1]
        elsif self.moved == false && !piece_on_target && !is_obstructed?(self.game,[x,y])
          valid_moves << [self.position_x,self.position_y-2]
        elsif self.position_x == x-1 && self.position_y == y+1 && can_capture?(x,y,"black")
          valid_moves << [self.position_x+1,self.position_y-1]
        elsif self.position_x == x+1 && self.position_y == y+1 && can_capture?(x,y,"black")
          valid_moves << [self.position_x-1,self.position_y-1]
        end
      else
        if self.position_x == x && self.position_y == y-1 && !piece_on_target 
          valid_moves << [self.position_x,self.position_y+1]
        elsif self.moved == false && !piece_on_target && !is_obstructed?(self.game,[x,y])
          valid_moves << [self.position_x,self.position_y+2]
        elsif self.position_x == x-1 && self.position_y == y-1 && can_capture?(x,y,"white")
          valid_moves << [self.position_x+1,self.position_y+1]
        elsif self.position_x == x+1 && self.position_y == y-1 && can_capture?(x,y,"white")
          valid_moves << [self.position_x-1,self.position_y+1]
        end
      end
    end
    valid_moves.include?([x,y])
  end
end
