class TurnsController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def do_turn
    @current_piece = Piece.find_by_id(piece_params[:id])

    @local_game_id = @current_piece.game_id
    @local_game = Game.find(@local_game_id)
    @local_pieces = @local_game.pieces

    @target_x = piece_params[:position_x].to_i
    @target_y = piece_params[:position_y].to_i
    @target = @local_game.pieces.where(position_x: @target_x, position_y: @target_y).first
    @old_x = @current_piece.position_x
    @old_y = @current_piece.position_y

    if @current_piece.valid_move?(@target_x, @target_y)
      @current_piece.move_to!(@target_x, @target_y)
      king = @local_game.pieces.where(type: "King", color: @current_piece.color)[0]
      if king.is_in_check? == true
        @current_piece.move_to!(@old_x, @old_y)
        if @target != nil
          @revert = Piece.find_by(id: @target.id)
          @revert.update_attributes!(position_x: @target_x, position_y: @target_y)
        end
        @local_game.next_player(@local_game.next_player_id)
      end
      @local_game.next_player(@local_game.next_player_id)
    else
      flash[:notice] = "That was not a valid move"
    end
    @local_game.reload
    redirect_to game_path(@local_game_id)
  end
end
