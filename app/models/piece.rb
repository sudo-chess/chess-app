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
  
    if @target.color != self.color
      @target.update_attributes(position_x: nil, position_y: nil)
      self.update_attributes(position_x: new_x, position_y: new_y, moved: true)
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
    in_checkmate = true
    
    #if no king is in check there cannot be any checkmate situation
    if !king.is_in_check?
      in_checkmate = false
    else
      #setting variables, check and store which piece(s) create the check situation
      x = king.position_x
      y = king.position_y
      if color == "black"  
        attacking_color = "white" 
      else
        attacking_color = "black"
      end

      threatening_pieces = []
      game.pieces.where(color: attacking_color).each do |piece|
        if piece.valid_move?(x,y)
          threatening_pieces << piece
        end  
      end

      #check if the king can move to a square where it is not in check.
      if king.escapable? 
        in_checkmate = false 
      end

      #check if there the threatening piece can be captured or obstructed. if more than one threatening  piece and the king can't escape, it means checkmate.
      if threatening_pieces.length > 1 
        if !king.escapable?
          in_checkmate = true
        end
    
      elsif threatening_pieces.length == 1
        th_x = threatening_pieces[0].position_x
        th_y = threatening_pieces[0].position_y

      #capture check
        game.pieces.where(color: color).each do |piece|
          if piece.valid_move?(th_x,th_y)
            in_checkmate = false
          end
        end

      #obstruct check
        game.pieces.where(color: color).each do |piece|
          if piece.type != "King"
            @squares.each do |square|
              if piece.valid_move?(square[0],square[1])
                orig_x = piece.position_x
                orig_y = piece.position_y
                piece.update_attributes(position_x: square[0], position_y: square[1])
                if threatening_pieces[0].is_obstructed?(king.position_x, king.position_y)
                  in_checkmate = false
                end
                piece.update_attributes(position_x: orig_x, position_y: orig_y)
              end
            end
          end
        end
      end     
    end
    return in_checkmate
  end



  def escapable?
    result = false
    k = self
    or_x = k.position_x
    or_y = k.position_y
    @squares.each do |position|
      if k.valid_move?(position[0], position[1])
        
        k.update_attributes(position_x: position[0], position_y: position[1])
        if k.is_in_check?
        result = false 
        else
        result = true
        end
        
        k.update_attributes(position_x: or_x, position_y: or_y)
      end
    end

    return result
  end



  # def is_in_stalemate?
  #   in_stalemate = true
  #   squares = []
  #   numbers = [1,2,3,4,5,6,7,8]
  #   numbers.each do |x|
  #     numbers.each do |y|
  #       squares << [x,y]
  #     end
  #   end
  #   game.pieces.each do |king|
  #     if king.name == "King" && king.is_in_check? == false
  #       game.pieces.each do |piece|
  #         if piece.color == king.color
  #           squares.each do |position|
  #             if piece.valid_move?(position[0],position[1]) == true && king.is_in_check? == false
  #               in_stalemate = false
  #             end
  #           end
  #         end
  #       end
  #     end
  #   end
  #   return in_stalemate
  # end

end
