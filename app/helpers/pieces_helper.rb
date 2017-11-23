module PiecesHelper


def highlight(x,y)
  @local_pieces.each do |item|
    if item != nil

      # if item.position_x == @current_coordinates[0] && item.position_y == @current_coordinates[1]
      if item.position_x == 1 && item.position_y == 1
          return "blablabla"
      end
    end
  end
  return nil
end


 def check_piece(x, y)

    @local_pieces.each do |item|
      if item != nil

        if item.position_x == x && item.position_y == y
          return link_to "#{item.color} #{item.type}", piece_path(item)
        end

      end
    end
    return nil
  end
end



 # @current_coordinates == [index, row_number] %>
 #            <b style="font-weight: bold">df </b>
    