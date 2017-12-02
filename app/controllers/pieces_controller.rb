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
      @current_piece = Piece.find_by_id(params[:id])
      @current_coordinates = [@current_piece.position_x, @current_piece.position_y]

      if @current_piece.valid_move?(piece_params[:position_x], piece_params[(:position_y)])
        @current_piece.update_attributes(piece_params)
      else
      flash[:notice] = "That was not a valid move"
      end

      redirect_to game_path(@local_game_id)

  end


  def move_to
    # url = request.original_url
    # uri = URI::parse(url)
    # id = uri.path.split('/')[-2]
    id = Piece.find(params[:piece_id])



    @local_game_id = Piece.find(id).game_id
    @target_piece = Piece.find(id)

    if $current.valid_move?(params[:position_x], params[:position_y])
      $current.move_to!(@target_piece.position_x, @target_piece.position_y)
    else
      flash[:notice] = "That was not a valid move"  
    end
        
    redirect_to game_path(@local_game_id)
  end

private
  def piece_params
      params.permit(:position_x, :position_y)
  end
end
