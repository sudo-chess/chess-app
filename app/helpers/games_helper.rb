module GamesHelper
  
  def check_piece(x, y)
    @local_pieces.each do |item|
      if item != nil
        if item.position_x == x && item.position_y == y
          return link_to "#{item.color} #{item.type}", piece_path(@local_game)
        end
      end
    end
    return "#{x}, #{y}"
  end
end
