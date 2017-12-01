require 'rails_helper'

RSpec.describe Piece, type: :model do

  describe "move_to!" do
      it "should successfully set the udate the coordinates to the new ones" do
        game = FactoryBot.create(:game)
        piece1 = game.pieces.create(position_x: 1, position_y: 1, color: "white", game_id: game.id)
        piece2 = game.pieces.create(position_x: 3, position_y: 3, color: "black", game_id: game.id)
        old_x_p2 = piece2.position_x
        old_y_p2 = piece2.position_y
        piece1.move_to!(piece2.position_x, piece2.position_y)
        new_x= piece1.position_x
        new_y= piece1.position_y
        expect([new_x, new_y]).to eq([old_x_p2,old_y_p2])
      end

      it "should successfully set the captured piece coordinates to nil" do
        game = FactoryBot.create(:game)
        piece1 = game.pieces.create(position_x: 1, position_y: 1, color: "white", game_id: game.id)
        piece2 = game.pieces.create(position_x: 3, position_y: 3, color: "black", game_id: game.id)
        piece1.move_to!(piece2.position_x, piece2.position_y)
        piece2.reload
        new_x_p2= piece2.position_x
        new_y_p2= piece2.position_y
        expect([new_x_p2, new_y_p2]).to eq([nil,nil])

      end


      it "should not do anything if the pieces have the same color" do
        game = FactoryBot.create(:game)
        piece1 = game.pieces.create(position_x: 1, position_y: 1, color: "white", game_id: game.id)
        piece2 = game.pieces.create(position_x: 3, position_y: 3, color: "white", game_id: game.id)

        old_x_p2 = piece2.position_x
        old_x_p2 = piece2.position_x
        old_x_p1 = piece1.position_x
        old_y_p1 =piece1.position_y

        piece1.move_to!(piece2.position_x, piece2.position_y)

        new_x_p1= piece1.position_x
        new_y_p1= piece1.position_y
        new_x_p2= piece2.position_x
        new_y_p2= piece2.position_y

        expect([[new_x_p1, new_y_p1],[new_x_p2, new_y_p2]]).to eq([[old_x_p1, old_y_p1],[new_x_p2, new_y_p2]])

      end
    end



  # add test for rook
  describe "valid_move?" do
    it "should return true if the move is valid for a rook" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = Rook.create(position_x: 1, position_y: 1, color: "white", game_id: game.id)

      # add code here
    end
  end



  describe "valid_move?" do
    it "should return false if the move is not valid for a rook" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = Rook.create(position_x: 1, position_y: 1, color: "white", game_id: game.id)

      # add code here
      var = piece1.valid_move?(2,1)
      expect(var).to eq(true)

      var2 = piece1.valid_move?(2,2)
      expect(var2).to eq(false)
    end
  end

 # knight
  describe "valid_move?" do
    it "should return true if the move is valid for a knight" do
      game = FactoryBot.create(:game)
      piece1 = Knight.create(position_x: 2, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(3,3)
      expect(var).to eq(true)

    end
  end

  describe "valid_move?" do
    it "should return false if the move is not valid for a knight" do
      game = FactoryBot.create(:game)
      piece1 = Knight.create(position_x: 2, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(3,4)
      expect(var).to eq(false)

    end
  end

  #bishop
  describe "valid_move?" do
    it "should return true if the move is valid for a bishop" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = Bishop.create(position_x: 3, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(8,6)
      expect(var).to eq(true)
    end
  end


    describe "valid_move?" do
    it "should return false if the move is valid for a bishop but is obstructed" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = Bishop.create(position_x: 3, position_y: 1, color: "white", game_id: game.id)
      piece2 = Pawn.create(position_x: 5, position_y: 3, color: "white", game_id: game.id)

      var = piece1.valid_move?(8,6)
      expect(var).to eq(false)
    end
  end

  #     describe "valid_move?" do
  #   it "should return false if the move is valid for a bishop but is obstructed ----attempt without factorybot-----" do
  #     Game.skip_callback(:create, :after, :populate_game!, raise: false)

  #     whiteplayer = User.create(white_player_id: 1)
  #     game = Game.create(white_player_id: whiteplayer.id)

  #     piece1 = Bishop.create(position_x: 3, position_y: 1, color: "white", game_id: game.id)
  #     piece2 = Pawn.create(position_x: 5, position_y: 3, color: "white", game_id: game.id)

  #     var = piece1.valid_move?(8,6)
  #     expect(var).to eq(false)
  #   end
  # end


  describe "valid_move?" do
    it "should return false if the move is not valid for a bishop" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = Bishop.create(position_x: 3, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(1,8)
      expect(var).to eq(false)
    end
  end



    describe "valid_move?" do
    it "should return false if the move is valid for a bishop but out of the board" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = Bishop.create(position_x: 3, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(9,7)
      expect(var).to eq(false)
    end
  end



  #queen
  describe "valid_move?" do
    it "should return true if the vertical move is valid for a queen" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = Queen.create(position_x: 4, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(4,8)
      expect(var).to eq(true)
    end
  end


  describe "valid_move?" do
    it "should return true if the diagonal move is valid for a queen" do
      # Game.skip_callback(:populate_game!)
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = Queen.create(position_x: 4, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(8,5)
      expect(var).to eq(true)
    end
  end

    describe "valid_move?" do
    it "should return false if valid move but obstructed" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = Queen.create(position_x: 1, position_y: 1, color: "white", game_id: game.id)
      piece2 = Pawn.create(position_x: 6, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(8,1)
      expect(var).to eq(false)
    end
  end

    describe "valid_move?" do
    it "should return false if the move is not valid for a queen" do
      Game.skip_callback(:create, :after, :populate_game!, raise: false)
      game = FactoryBot.create(:game)
      piece1 = Queen.create(position_x: 4, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(5,7)
      expect(var).to eq(false)
    end
  end



  #king
  describe "valid_move?" do
    it "should return true if the move is valid for a king" do
      game = FactoryBot.create(:game)
      piece1 = King.create(position_x: 5, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(5,2)
      expect(var).to eq(true)
    end
  end

  describe "valid_move?" do
    it "should return false if the move is not valid for a king" do
      game = FactoryBot.create(:game)
      piece1 = King.create(position_x: 5, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(1,2)
      expect(var).to eq(false)
    end
  end

  #add code for pawn
  describe "valid_move?" do
    it "should return true if the move is valid for a pawn" do
      game = FactoryBot.create(:game)
      piece1 = Pawn.create(position_x: 1, position_y: 2, color: "white", game_id: game.id)

      # add code here
    end
  end

  describe "valid_move?" do
    it "should return false if the move is not valid for a pawn" do
      game = FactoryBot.create(:game)
      piece1 = Pawn.create(position_x: 1, position_y: 2, color: "white", game_id: game.id)

      # add code here
    end
  end
end
