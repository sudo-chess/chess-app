module GamesHelper
  
  def check_piece(x, y)
    current_game = @g.id
    @p.each do |item|
      if item != nil
        if item.position_x == x && item.position_y == y
          return "#{item.color} #{item.type}"
        end
      end
    end
    nil
  end
end
