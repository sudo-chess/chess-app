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
    render action: :index
  end

  def playing
    @game = Game.playing
    render action: :index
  end

  def complete
    @game = Game.complete
    render action: :index
  end

  def new
    @game = Game.new
  end


  def create
    opponent_id = game_params[:black_player_id]
    @game = Game.create(:black_player_id => opponent_id, :white_player_id => current_user.id, :next_player_to_move_id => current_user.id)
    redirect_to game_path(@game)
  end


  def forfeit
    @game = Game.find(params[:id])
    @game.forfeit!(current_user)
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:black_player_id, :result)
  end


end
