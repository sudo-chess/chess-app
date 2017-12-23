module GamesHelper
  
 def check_piece(x, y)
    @pieces.each do |piece|
      if piece != nil        
        if piece.position_x == x && piece.position_y == y
          # return link_to image_tag(piece.image, :class=>"img-responsive", :id =>"draggable"), piece_path(piece, position_x: x, position_y: y), :method => :put, :id =>"draggable"
          if piece.color == "white"
            return image_tag(piece.image, :class=>"img-responsive white-piece")
          else
            return image_tag(piece.image, :class=>"img-responsive black-piece")
          end          
        end
      end
    end
    return  content_tag(:div, "", class: "square")

    
  end
end



