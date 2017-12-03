module GamesHelper
  
#  def check_piece(x, y)
#     @local_pieces.each do |item|
#       if item != nil
#         if item.position_x == x && item.position_y == y       
#           # return link_to image_tag(item.image, :class=>"img-responsive", :id =>"draggable"), piece_path(item)
#           return image_tag(item.image, :class=>"img-responsive", :id =>"draggable")
#         end
#       end
#     end
#     return nil
#   end
# end



 def check_piece(x, y)
    @local_pieces.each do |piece|
      if piece != nil
        if piece.position_x == x && piece.position_y == y
          # return link_to image_tag(piece.image, :class=>"img-responsive", :id =>"draggable"), piece_path(piece, position_x: x, position_y: y), :method => :put, :id =>"draggable"
          return image_tag(piece.image, :class=>"img-responsive", :id =>"draggable")
        end
      end
    end

    # return link_to '', piece_path(@current_piece.id, position_x: x, position_y: y), :method => :put, :class => "square", :id => "droppable"
    # return   :class => "square", :id => "droppable"
    # return  content_tag("rrr") :div, class: "square", id: "droppable"
    return  content_tag(:div, "", class: "square", id: "droppable")

    
  end
end



