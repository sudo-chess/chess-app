class PiecesController < ApplicationController

  def show
      @local_game_id = Piece.find_by_id(params[:id]).game_id
      @local_game = Game.find_by_id(@local_game_id)
      @local_pieces = @local_game.pieces
  end


end
