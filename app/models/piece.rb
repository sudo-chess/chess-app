class Piece < ApplicationRecord
  belongs_to :game

  def occupied_positions
    occupied_positions = []
    game.pieces.each do |piece|
      occupied_positions << [piece.position_x, piece.position_y]
    end
    occupied_positions
  end

   def move_to!(new_x, new_y)
    @current_game = self.game
    @target = @current_game.pieces.where(position_x: new_x, position_y: new_y)[0]


    #cases for castling
    if @target == nil && self.type == "King" && self.moved == false && new_x == 7
      self.castle!("kingside_castle", self.color)
    elsif @target == nil && self.type == "King" && self.moved == false && new_x == 3
      self.castle!("queenside_castle", self.color)
    end

    #cases for pawn promotion
    if @target == nil && self.color == "white" && new_y == 8 && self.type == "Pawn"
      self.promotion(new_x, new_y)
    elsif @target == nil && self.color == "black"  && new_y == 1 && self.type == "Pawn"
      self.promotion(new_x, new_y)
    elsif self.color == "white"  && new_y == 8 && self.type == "Pawn"
      @target.update_attributes!(position_x: nil, position_y: nil)
      self.promotion(new_x, new_y)
    elsif self.color == "black" && new_y == 1 && self.type == "Pawn"
      @target.update_attributes!(position_x: nil, position_y: nil)
      self.promotion(new_x, new_y)
    #in case on piece on destination
    elsif @target == nil
      self.update_attributes!(position_x: new_x, position_y: new_y, moved: true)
    #in case piece on destination
    elsif @target.color != self.color
      @target.update_attributes!(position_x: nil, position_y: nil)
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
    if (@x1-@x2).abs == (@y1-@y2).abs
      @x1 , @x2 = @x2 , @x1 if @x1 > @x2
      @y1 , @y2 = @y2 , @y1 if @y1 > @y2

      x_ary = (@x1+1...@x2).to_a
      y_ary = (@y1+1...@y2).to_a
      @squares_to_check = x_ary.zip(y_ary)

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
    game = self.game
    in_checkmate = true
    @squares = []
    numbers = [1,2,3,4,5,6,7,8]
    numbers.each do |x|
      numbers.each do |y|
        @squares << [x,y]
      end
    end
 
    color = self.color
    king = self
    x,y = king.position_x, king.position_y
    color == "black" ? attacking_color = "white" : attacking_color = "black"

    if !king.is_in_check?
      return false
    else
      @threatening_pieces = []
      game.pieces.where(color: attacking_color).each do |piece|
        @threatening_pieces << piece if piece.valid_move?(x,y)
      end

      return false if king.escapable?
     
      #check if there the threatening piece can be captured or obstructed. if more than one threatening piece and the king can't escape, it means checkmate.
      if @threatening_pieces.length > 1 
        in_checkmate = true if !king.escapable?
    
      elsif @threatening_pieces.length == 1
        in_checkmate = false if threat_capturable?
        in_checkmate = false if king.obstructable?
      end     
    end
    return in_checkmate
  end


  def threat_capturable?
    th_x, th_y = @threatening_pieces[0].position_x, @threatening_pieces[0].position_y
    game.pieces.where(color: color).each do |piece|
      return true if piece.valid_move?(th_x,th_y)
    end
    return false
  end

  def obstructable?
    game.pieces.where(color: self.color).each do |piece|
      if piece.type != "King"
        @squares.each do |square|
          if piece.valid_move?(square[0],square[1])
            orig_x = piece.position_x
            orig_y = piece.position_y
            piece.move_to!(square[0], square[1])
            if @threatening_pieces[0].is_obstructed?(self.position_x, self.position_y)
              piece.move_to!(orig_x, orig_y)
              return true
            end
            piece.move_to!(orig_x, orig_y)
          end
        end
      end
    end
    return false
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
      [self.position_x-1,self.position_y-1]
    ]
    king = self
    can_escape = false
    valid_moves.each do |escape|
      if king.valid_move?(escape[0],escape[1]) && king.is_on_board?(escape[0],escape[1])
        if king.is_in_check?(escape[0],escape[1]) == false
          can_escape = true
        end
      end
    end
    return can_escape
  end
end


  # def escapable?
  #   @squares = []
  #   numbers = [1,2,3,4,5,6,7,8]
  #   numbers.each do |x|
  #     numbers.each do |y|
  #       @squares << [x,y]
  #     end
  #   end
  #   or_x = self.position_x
  #   or_y = self.position_y
  #   # @squares.delete([or_x, or_y])
  #   @squares.each do |position|
  #     if self.valid_move?(position[0], position[1])
  #       if self.move_to!(position[0], position[1])
  #         self.move_to!(position[0], position[1])
  #         game.reload
  #         if !self.is_in_check?
  #           return true
  #         end
  #       end
  #         self.move_to!(or_x, or_y)
  #         game.reload
  #     end
  #   end
  #   return false
  # end

# end
