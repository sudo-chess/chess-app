class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
    @game = Game.find_by_id(params[:id])
    @pieces = @game.pieces
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
    @game = Game.create(:black_player_id => opponent_id, :white_player_id => current_user.id, :next_player_id => current_user.id)
    redirect_to game_path(@game)
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(:black_player_id => current_user.id)
    redirect_to game_path(@game)
  end

  def forfeit
    @game = Game.find(params[:id])
    @game.forfeit!(current_user)
    redirect_to root_path
  end

  def castle_king_side
    @game = Game.find(params[:id])
    if @game.next_player_id == @game.white_player_id
      color = "white"
    else
      color = "black"
    end
    king = @game.pieces.where(type: "King", color: color)[0]
    if king.can_castle
      king.castle!("kingside_castle", color)
      @game.next_player(@game.next_player_id)
      redirect_to game_path(@game)
    end
  end

  def castle_queen_side
    @game = Game.find(params[:id])
    if @game.next_player_id == @game.white_player_id
      color = "white"
    else
      color = "black"
    end
    king = @game.pieces.where(type: "King", color: color)[0]
    if king.can_castle
      king.castle!("queenside_castle", color)
      @game.next_player(@game.next_player_id)
      redirect_to game_path(@game)
    end
  end


  private

  def game_params
    params.require(:game).permit(:black_player_id, :result)
  end


end
