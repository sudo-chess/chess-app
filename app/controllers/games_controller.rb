class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
      @g = Game.find_by_id(params[:id])
      @p = @g.pieces
  end

  # def piece_check(x, y)
  #   @g = Game.find_by_id(params[:id])
  #   @p = Piece.all
  #   current_game = @g.id
  #   @p.each do |test| 
  #     if test.game_id == current_game
  #       if test.position_x == x   && test.position_y == y
  #         return test.color
  #         return test.type
  #       end
  #     end
  #   end
  #   helper_method :piece_check
  # end

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

  private 

  def game_params
    params.require(:game).permit(:black_player_id)  
  end

  # def add_func(a=0, b=0)
  #   return a + b
  # end
end
