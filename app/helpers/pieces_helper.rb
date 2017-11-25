module PiecesHelper

 def check_piece2(x, y)
    @local_pieces.each do |item|
      if item != nil
        if item.position_x == x && item.position_y == y
          return link_to image_tag(item.image, :class=>"img-responsive"), piece_move_to_path(item)
        end
      end
    end

    return link_to '', piece_path(@current_piece.id, position_x: x, position_y: y), :method => :put, :class => "square"

  end
end

    