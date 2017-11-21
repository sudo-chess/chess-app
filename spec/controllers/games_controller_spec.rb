require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "is_obstructed?" do
    it "should return true because it is obstructed" do
      
      game = FactoryBot.create(:game)
 
      piece1 = game.pieces.create(position_x: 7, position_y: 7, game_id: game.id)
      piece2 = game.pieces.create(position_x: 7, position_y: 5, game_id: game.id)
      variable = piece1.is_obstructed?(game,[7,3])
      expect(variable).to eq(true)

    end
  end

    describe "is_obstructed?" do
    it "should return false because it is not obstructed" do
      
      game = FactoryBot.create(:game)
      piece1 = game.pieces.create(position_x: 7, position_y: 7, game_id: game.id)
      piece2 = game.pieces.create(position_x: 2, position_y: 2, game_id: game.id)
      variable = piece1.is_obstructed?(game,[3,3])
      expect(variable).to eq(false)
    end
  end

  describe "is_obstructed?" do
    it "should return false because it is not obstructed, even if destination square is occupied" do
      
      game = FactoryBot.create(:game)
      piece1 = game.pieces.create(position_x: 7, position_y: 7, game_id: game.id)
      piece2 = game.pieces.create(position_x: 2, position_y: 2, game_id: game.id)
      variable = piece1.is_obstructed?(game,[2,2])
      expect(variable).to eq(false)
    end
  end

  describe "is_obstructed?" do
    it "should return Invalid statement because it is not a linear move" do
      
      game = FactoryBot.create(:game)
      piece1 = game.pieces.create(position_x: 2, position_y: 2, game_id: game.id)
      piece2 = game.pieces.create(position_x: 6, position_y: 6, game_id: game.id)
      variable = piece1.is_obstructed?(game,[1,7])
      expect(variable).to eq("Invalid input.  Not diagnal, horizontal, or vertical.")
    end
  end

  describe "game create" do
    it "should create a game with 32 pieces" do
      game = FactoryBot.create(:game)
      count = game.pieces.collect{|piece| piece}.length
      expect(count).to eq(32)
    end
  end

 

end
