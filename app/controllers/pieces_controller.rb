class PiecesController < ApplicationController

  def show
      @local_game_id = Piece.find_by_id(params[:id]).game_id
      @local_game = Game.find_by_id(@local_game_id)
      @local_pieces = @local_game.pieces
      
      @current_piece = Piece.find_by_id(params[:id])
      @current_coordinates = [@current_piece.position_x, @current_piece.position_y]

  end


  def update
      @local_game_id = Piece.find_by_id(params[:id]).game_id
      @current_piece = Piece.find_by_id(params[:id])
      @current_coordinates = [@current_piece.position_x, @current_piece.position_y]

      @current_piece.update_attributes(piece_params)
      redirect_to game_path(@local_game_id)
  end


private
  def piece_params
      params.permit(:position_x, :position_y)
  end
end
