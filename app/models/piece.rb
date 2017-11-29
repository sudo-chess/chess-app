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
      self.update_attributes(position_x: new_x, position_y: new_y)
    end
  end
   

  def is_obstructed?(game, pos2) 

    pos1=[self.position_x,self.position_y]

    @x1=pos1[0]
    @y1=pos1[1]
    @x2=pos2[0]
    @y2=pos2[1]

    @squares_to_check = []
    
    # check if correct move
    if !((@x1 == @x2) || (@y1 == @y2) || ((@x1-@x2).abs == (@y1-@y2).abs))
      return "Invalid input.  Not diagnal, horizontal, or vertical."
    # check if obstructed
    elsif
     is_vertically_obstructed?(pos1, pos2) ||   is_horizontally_obstructed?(pos1, pos2) ||   is_diagonally_obstructed?(pos1, pos2)
      return true
    else
      return false
    end
  end

  def check_squares
    (@squares_to_check & occupied_positions).length > 0? true : false  
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
    ((1..8).include?(x) && (1..8).include?(y))? true : false
  end

end
