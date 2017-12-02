class PiecesController < ApplicationController

  def show
      @local_game_id = Piece.find_by_id(params[:id]).game_id
      @local_game = Game.find_by_id(@local_game_id)
      @local_pieces = @local_game.pieces
     
      @current_piece = Piece.find_by_id(params[:id])
      @current_coordinates = [@current_piece.position_x, @current_piece.position_y]
      $current = @current_piece

  end


  def update
      @local_game_id = Piece.find_by_id(params[:id]).game_id
      @local_game = Game.find(@local_game_id)

      @current_piece = Piece.find_by_id(params[:id])
      @current_coordinates = [@current_piece.position_x, @current_piece.position_y]

      @target_x = piece_params[:position_x]
      @target_y = piece_params[:position_y]
      @target = @local_game.pieces.where(position_x: @target_x, position_y: @target_y)

      #checks if there is a piece at destination. if object.lenght==0, it means the square is empty
      if @target.length == 0
        if @current_piece.valid_move?(piece_params[:position_x], piece_params[(:position_y)])
          @current_piece.update_attributes(piece_params)
        else
        flash[:notice] = "That was not a valid move"
        end
      else
        if $current.valid_move?(@target_x, @target_y)
          $current.move_to!(@target_x, @target_y)
        else
          flash[:notice] = "That was not a valid move"  
        end
      end

      redirect_to game_path(@local_game_id)
  end



private
  def piece_params
      params.permit(:position_x, :position_y)
  end
end
