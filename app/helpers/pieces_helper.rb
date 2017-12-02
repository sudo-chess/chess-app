module PiecesHelper

 def check_piece2(x, y)
    @local_pieces.each do |piece|
      if piece != nil
        if piece.position_x == x && piece.position_y == y
          return link_to image_tag(piece.image, :class=>"img-responsive"), piece_path(piece, position_x: x, position_y: y), :method => :put
        end
      end
    end

    return link_to '', piece_path(@current_piece.id, position_x: x, position_y: y), :method => :put, :class => "square"

  end
end

    