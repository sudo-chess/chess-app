require 'rails_helper'

RSpec.describe Game, type: :model do
  
  
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

  # is_in_stalemate tests

  describe "is_stalemate?(color)" do
    it "should return true if the color player is in stalemate" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = King.create(position_x: 2, position_y: 8, color: 'black', game_id: game.id, moved: true)
      piece2 = King.create(position_x: 2, position_y: 6, color: 'white', game_id: game.id, moved: true)
      piece3 = Rook.create(position_x: 1, position_y: 1, color: 'white', game_id: game.id)
      piece4 = Rook.create(position_x: 3, position_y: 1, color: 'white', game_id: game.id)
      var = game.is_stalemate?('black')
      expect(var).to eq(true)
    end
  end

  describe "is_stalemate?(color)" do
    it "should return false if the color player is in not stalemate" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = King.create(position_x: 2, position_y: 8, color: 'black', game_id: game.id, moved: true)
      piece2 = King.create(position_x: 2, position_y: 6, color: 'white', game_id: game.id, moved: true)
      piece3 = Rook.create(position_x: 1, position_y: 1, color: 'white', game_id: game.id)
      piece4 = Rook.create(position_x: 4, position_y: 1, color: 'white', game_id: game.id)
      var = game.is_stalemate?('black')
      expect(var).to eq(false)
    end
  end


  describe "is_stalemate?(color)" do
    it "should return true if the color player is in stalemate" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)  
      piece1 = King.create(position_x: 1, position_y: 8, color: 'white', game_id: game.id, moved: true)
      piece2 = Queen.create(position_x: 3, position_y: 7, color: 'black', game_id: game.id)
      var = game.is_stalemate?('white')
      expect(var).to eq(true)
    end
  end


    describe "is_stalemate?(color)" do
    it "should return false if the color player is not in stalemate" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece2 = King.create(position_x: 1, position_y: 8, color: 'white', game_id: game.id, moved: true)
      piece3 = Queen.create(position_x: 4, position_y: 7, color: 'black', game_id: game.id)
      var = game.is_stalemate?('white')
      expect(var).to eq(false)
    end
  end

   describe "is_stalemate?(color)" do
    it "should return false if the color player is not in stalemate" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game) 
      piece1 = King.create(position_x: 1, position_y: 8, color: 'white', game_id: game.id, moved: true)
      piece2 = Pawn.create(position_x: 4, position_y: 4, color: 'white', game_id: game.id)
      piece3 = Queen.create(position_x: 3, position_y: 7, color: 'black', game_id: game.id)
      var = game.is_stalemate?('white')
      expect(var).to eq(false)
    end
  end


end
