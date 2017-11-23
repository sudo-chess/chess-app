class PiecesController < ApplicationController
  def show
      @local_game = Game.find_by_id(params[:id])
      @local_pieces = @local_game.pieces
  end
end
