require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

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

    # it "should successfully set the captured piece coordinates to nil" do
    #   game = FactoryBot.create(:game)
    #   piece1 = game.pieces.create(position_x: 1, position_y: 1, color: "white", game_id: game.id)
    #   piece2 = game.pieces.create(position_x: 3, position_y: 3, color: "black", game_id: game.id)
    #   piece1.move_to!(piece2.position_x, piece2.position_y)
    #   new_x_p2= piece2.position_x
    #   new_y_p2= piece2.position_y
    #   expect([new_x_p2, new_y_p2]).to eq([nil,nil])
    
    # end


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

  describe "valid_move?" do
    it "should return true if the move is valid for a knight" do
      game = FactoryBot.create(:game)
      piece1 = Knight.create(position_x: 2, position_y: 1, color: "white", game_id: game.id)

      var = piece1.valid_move?(3,3)
      expect(var).to eq(true)

    end
  end

    describe "valid_move?" do
    it "should return true if the move is valid for a king" do


    end
  end

      describe "valid_move?" do
    it "should return true if the move is valid for a queen" do

    end
  end

      describe "valid_move?" do
    it "should return true if the move is valid for a bishop" do


    end
  end

      describe "valid_move?" do
    it "should return true if the move is valid for a rook" do


    end
  end

    describe "valid_move?" do
    it "should return true if the move is valid for a pawn" do


    end
  end

end


