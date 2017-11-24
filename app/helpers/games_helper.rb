module GamesHelper
  
 def check_piece(x, y)
    @local_pieces.each do |item|
      if item != nil
        if item.position_x == x && item.position_y == y       
          return link_to image_tag(item.image, :class=>"img-responsive"), piece_path(item)
        end
      end
    end
    return nil
  end
end


