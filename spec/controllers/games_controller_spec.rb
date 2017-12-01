require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


  describe "game create" do
    it "should create a game with 32 pieces, 16 white and 16 black" do
      game = FactoryBot.create(:game)
      count = game.pieces.collect{|piece| piece}.length
      expect(count).to eq(32)
      white_pieces = game.pieces.select{|piece| piece.color == 'white'}
      expect(white_pieces.length).to eq(16)
      black_pieces = game.pieces.select{|piece| piece.color == 'black'}
      expect(black_pieces.length).to eq(16)
    end
  end

  describe "game create" do
    it "should have the 16 pawns at the good position" do
      game = FactoryBot.create(:game)
      pawns = game.pieces.select{|piece| piece.type == 'Pawn'}
      count = pawns.count
      expect(count).to eq(16)
      pawns_x = pawns.map{|pawn| pawn.position_x}
      pawns_y = pawns.map{|pawn| pawn.position_y}
      pawn_coordinates = pawns_x.zip(pawns_y)
      expected_positions = []
      [2,7].each do |y|
        (1..8).each do |x|
          expected_positions << [x,y]
        end
      end
      check = (pawn_coordinates & expected_positions).length
      expect(check).to eq(16)
    end
  end

  describe "game create" do
    it "it should have 8 white pawns and 8 blacks" do
       game = FactoryBot.create(:game) 
       white_pawns = game.pieces.select{|piece| piece.type == 'Pawn' &&  piece.color == 'white'}
       expect(white_pawns.length).to eq(8)
       black_pawns = game.pieces.select{|piece| piece.type == 'Pawn' &&  piece.color == 'black'}
       expect(white_pawns.length).to eq(8)
    end
  end

    describe "game create" do
      it "it should have 2 white bishops and 1 blacks queen" do
         game = FactoryBot.create(:game) 
         white_bishops = game.pieces.select{|piece| piece.type == 'Bishop' &&  piece.color == 'white'}
         expect(white_bishops.length).to eq(2)
         black_queen = game.pieces.select{|piece| piece.type == 'Queen' &&  piece.color == 'black'}
         expect(black_queen.length).to eq(1)
      end
    end

    describe "game create" do
      it "kings should be correctly placed" do
         game = FactoryBot.create(:game) 

         white_king = game.pieces.select{|piece| piece.type == 'King' &&  piece.color == 'white'}
         white_king_position = [white_king[0].position_x, white_king[0].position_y]
         expect(white_king_position).to eq([5,1])
         black_king = game.pieces.select{|piece| piece.type == 'King' &&  piece.color == 'black'}
         black_king_position = [black_king[0].position_x, black_king[0].position_y]
         expect(black_king_position).to eq([5,8])
      end
    end

    describe "game create" do
      it "knights should be correctly placed" do
         game = FactoryBot.create(:game) 
         knights = game.pieces.select{|piece| piece.type == 'Knight'}
         knight_positions_x = knights.map{|knight| knight.position_x}
         knight_positions_y = knights.map{|knight| knight.position_y}
         knight_positions = knight_positions_x.zip(knight_positions_y)
         expect(knight_positions).to eq([[2,1],[7,1],[2,8], [7,8]])

      end
    end



end
