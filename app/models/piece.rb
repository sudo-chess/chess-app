class Piece < ApplicationRecord
  belongs_to :game
 
  def occupied_positions
    occupied_positions = []
    game.pieces.each do |piece|
      occupied_positions << [piece.position_x, piece.position_y]
    end
    occupied_positions
  end

   def move_to!(new_x, new_y, promo = nil)
    target = self.game.pieces.where(position_x: new_x, position_y: new_y)[0]

    #cases for castling
    if target == nil && self.type == "King" && self.moved == false && new_x == 7 && self.game.pieces.where(position_x: 6, position_y: self.position_y)[0] == nil
      self.castle!("kingside_castle", self.color)
    elsif target == nil && self.type == "King" && self.moved == false && new_x == 3 && self.game.pieces.where(position_x: 4, position_y: self.position_y)[0] == nil && self.game.pieces.where(position_x: 2, position_y: self.position_y)[0] == nil
      self.castle!("queenside_castle", self.color)
    end

    #cases for pawn promotion
    if target == nil && self.color == "white" && new_y == 8 && self.type == "Pawn"
      self.promotion(new_x, new_y, promo)
    elsif target == nil && self.color == "black"  && new_y == 1 && self.type == "Pawn"
      self.promotion(new_x, new_y, promo)
    elsif self.color == "white"  && new_y == 8 && self.type == "Pawn"
      target.update_attributes!(position_x: nil, position_y: nil)
      self.promotion(new_x, new_y, promo)
    elsif self.color == "black" && new_y == 1 && self.type == "Pawn"
      target.update_attributes!(position_x: nil, position_y: nil)
      self.promotion(new_x, new_y, promo)
    #in case on piece on destination
    elsif target == nil
      self.update_attributes!(position_x: new_x, position_y: new_y, moved: true)
    #in case piece on destination
    elsif target.color != self.color
      target.update_attributes!(position_x: nil, position_y: nil)
      self.update_attributes!(position_x: new_x, position_y: new_y, moved: true)
    else
      return false
    end
  end



  def is_obstructed?(game, pos2)

    pos1=[self.position_x,self.position_y]

    @x1=pos1[0].to_i
    @y1=pos1[1].to_i
    @x2=pos2[0].to_i
    @y2=pos2[1].to_i

    @squares_to_check = []

    # check if correct move
    if !((@x1 == @x2) || (@y1 == @y2) || ((@x1-@x2).abs == (@y1-@y2).abs))
      return "Invalid input.  Not diagnal, horizontal, or vertical."
    # check if obstructed
    elsif
     is_vertically_obstructed?(pos1, pos2) || is_horizontally_obstructed?(pos1, pos2) || is_diagonally_obstructed?(pos1, pos2)
      return true
    else
      return false
    end
  end

  def check_squares
    (@squares_to_check & occupied_positions).length > 0 
  end

  def is_vertically_obstructed?(pos1,pos2)
    if @x1 == @x2
      @y1 , @y2 = @y2 , @y1 if @y1 > @y2
      (@y1+1...@y2).each do |y|
        @squares_to_check << [@x1, y]
      end
    check_squares
    end
  end

  def is_horizontally_obstructed?(pos1,pos2)
    if @y1 == @y2
      @x1 , @x2 = @x2 , @x1 if @x1 > @x2
      (@x1+1...@x2).each do |x|
        @squares_to_check << [x, @y1]
      end
    check_squares
    end
  end


  def is_diagonally_obstructed?(pos1,pos2)
      x1, y1 = @x1, @y1
      x2, y2 = @x2, @y2
    if (@x1-@x2).abs == (@y1-@y2).abs
      @x1 , @x2 = @x2 , @x1 if @x1 > @x2
      @y1 , @y2 = @y2 , @y1 if @y1 > @y2

      x_ary = (@x1+1...@x2).to_a
      y_ary = (@y1+1...@y2).to_a

      if x1 > x2 && y1 < y2
        x_ary.reverse!
        @squares_to_check = x_ary.zip(y_ary)
      elsif x1 < x2 && y1 > y2
        y_ary.reverse!
        @squares_to_check = x_ary.zip(y_ary)
      else 
        @squares_to_check = x_ary.zip(y_ary)
      end

    check_squares
    end
  end

  def self.get_image(color)
    # return the image file for the piece
  end


  def self.valid_move?(x,y)
    #calling the method valid_move that is individually defined for each type of piece, same way that was done with get_image
  end

  def is_on_board?(x,y)
    ((1..8).include?(x.to_i) && (1..8).include?(y.to_i))
  end

  def is_in_check?(x = self.position_x, y = self.position_y)
    game = self.game
    in_check = false
    game.pieces.each do |enemy|
      if enemy.color != self.color
        if enemy.valid_move?(x,y)
         in_check = true
        end
      end
    end
    return in_check
  end


  def is_in_checkmate?
    king = self
    game = self.game
    is_checkmate = true
    color = king.color
    @threatening_pieces = []
    
    game.pieces.each do |enemy|
      if enemy.color != self.color
        if enemy.valid_move?(king.position_x,king.position_y) == true 
         @threatening_pieces << enemy
        end
      end
    end
    
    if king.is_in_check? == false || king.escapable? == true
      is_checkmate = false
    elsif @threatening_pieces.length == 1
      enemy = @threatening_pieces[0]
      if king.obstructable? == true 
        is_checkmate = false
      end
    end
    is_checkmate
  end

  def escapable?
    valid_moves = [
      [self.position_x+1,self.position_y+1],
      [self.position_x+1,self.position_y],
      [self.position_x+1,self.position_y-1],
      [self.position_x,self.position_y+1],
      [self.position_x,self.position_y-1],
      [self.position_x-1,self.position_y+1],
      [self.position_x-1,self.position_y],
      [self.position_x-1,self.position_y-1]]
    king = self
    can_escape = false
    valid_moves.each do |escape|
      if king.valid_move?(escape[0],escape[1]) && king.is_on_board?(escape[0],escape[1])
        if king.is_in_check?(escape[0],escape[1]) == false
          unknown = self.game.pieces.where(position_x: escape[0], position_y: escape[1])[0]
          if unknown == nil || unknown.color != king.color
            can_escape = true
          end
        end
      end
    end
    return can_escape
  end

  def obstructable?
    can_protect = false
    king = self
    @squares = []
    numbers = [1,2,3,4,5,6,7,8]
    numbers.each do |x|
      numbers.each do |y|
        @squares << [x,y]
      end
    end

    game.pieces.each do |piece|
      if piece.type != "King" && king.color == piece.color
        @squares.each do |square|
          target = self.game.pieces.where(position_x: square[0], position_y: square[1])[0]
          if piece.valid_move?(square[0],square[1]) && target == nil
            orig_x = piece.position_x
            orig_y = piece.position_y
            piece.update_attributes!(position_x: square[0],position_y: square[1])
            if king.is_in_check? == false
              can_protect = true
            end
            piece.update_attributes!(position_x: orig_x,position_y: orig_y)
          end
        end
      end
    end
    return can_protect
  end

  def is_in_stalemate?
    king = self
    game = self.game
    is_stalemate = true
    color = king.color

    if king.is_in_check? == true
      is_stalemate = false
    elsif king.escapable? == true
      is_stalemate = false
    elsif king.not_stalemate? == true
      is_stalemate = false  
    end

    return is_stalemate
  end

  def not_stalemate?
    can_move = false
    king = self
    @squares = []
    numbers = [1,2,3,4,5,6,7,8]
    numbers.each do |x|
      numbers.each do |y|
        @squares << [x,y]
      end
    end

    game.pieces.each do |piece|
      if piece.type != "King" && king.color == piece.color
        @squares.each do |square|
          target = game.pieces.where(position_x: square[0], position_y: square[1], color: king.color)[0]
          if piece.valid_move?(square[0],square[1]) && target == nil #(target.color != king.color || target == nil)
            orig_x = piece.position_x
            orig_y = piece.position_y
            piece.update_attributes!(position_x: square[0],position_y: square[1])
            if king.is_in_check? == false
              can_move = true
            end
            piece.update_attributes!(position_x: orig_x,position_y: orig_y)
          end
        end
      end
    end
    return can_move
  end
end