class Piece < ApplicationRecord
  belongs_to :game

  def is_obstructed?(game, pos2)
    
    @occupied_positions =[]
    game.pieces.each do |piece|
      @occupied_positions << [piece.position_x, piece.position_y]
    end
      
    

    @occupied_positions 
    # defining the variables for the methods
    
    pos1=[self.position_x,self.position_y]

    @x1=pos1[0]
    @y1=pos1[1]
    @x2=pos2[0]
    @y2=pos2[1]

    @squares_to_check = []
    
    # check if correct move
    if !((@x1 == @x2) || (@y1 == @y2) || ((@x1-@x2).abs == (@y1-@y2).abs))
      return "Invalid input.  Not diagnal, horizontal, or vertical."
    # check if occupied
    elsif
     is_vertically_obstructed?(pos1, pos2) ||   is_horizontally_obstructed?(pos1, pos2) ||   is_diagonally_obstructed?(pos1, pos2)
      return true
    else
      return false
    end
  end

  def check_squares
    (@squares_to_check & @occupied_positions).length > 0? true : false  
  end

  def is_vertically_obstructed?(pos1,pos2)
    if @x1 == @x2
      @y1 , @y2 = @y2 , @y1 if @y1 > @y2
      for y in (@y1+1...@y2)
        @squares_to_check << [@x1, y]
      end
    check_squares
    end
    
  end

  def is_horizontally_obstructed?(pos1,pos2)
    if @y1 == @y2
      @x1 , @x2 = @x2 , @x1 if @x1 > @x2
      for x in (@x1+1...@x2)
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



end
