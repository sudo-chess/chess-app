class GamesController < ApplicationController


  def index
    @games = Game.all
  end

  def show
      @local_game = Game.find_by_id(params[:id])
      @local_pieces = @local_game.pieces
  end

  def pending
    @game = Game.pending
  end

  def playing
    @game = Game.playing
  end

  def complete
    @game = Game.complete
  end

  def new
    @game = Game.new
  end

  def create
    opponent_id = game_params[:black_player_id]
    @game = Game.create(:black_player_id => opponent_id, :white_player_id => current_user.id)
    redirect_to game_path(@game)
  end

  def update
    @game = Game.find_by_id(params:id)
    @game.update_attribute(game_params)
  end

  private

  def game_params
    params.require(:game).permit(:black_player_id, :result)
  end


end
