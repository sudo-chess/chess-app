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
      true_move = piece1.valid_move?(2,1)
      expect(true_move).to eq(true)

      false_move = piece1.valid_move?(2,2)
      expect(false_move).to eq(false)
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

      var = piece1.valid_move?(1,3)
      expect(var).to eq(true)
    end
  end

  describe "valid_move?" do
    it "should return true if the move is valid for a pawn" do
      game = FactoryBot.create(:game)
      piece1 = Pawn.create(position_x: 1, position_y: 2, color: "white", game_id: game.id)
      
      var = piece1.valid_move?(1,4)
      expect(var).to eq(true)
    end
  end

  describe "valid_move?" do
    it "should return true if pawn can make diagonal capture" do
      game = FactoryBot.create(:game)
      piece1 = Pawn.create(position_x: 1, position_y: 2, color: "white", game_id: game.id)
      piece2 = Pawn.create(position_x: 2, position_y: 3, color: "black", game_id: game.id)
      
      var = piece1.valid_move?(2,3)
      expect(var).to eq(true)
    end
  end

  describe "valid_move?" do
    it "should return false if the move is not valid for a pawn" do
      game = FactoryBot.create(:game)
      piece1 = Pawn.create(position_x: 1, position_y: 2, color: "white", game_id: game.id)
      piece2 = Pawn.create(position_x: 1, position_y: 3, color: "black", game_id: game.id)

      var = piece1.valid_move?(1,3)
      expect(var).to eq(false)
    end
  end

  describe "valid_move?" do
    it "should return false if pawn can not make a diagonal without enemy pawn at position" do
      game = FactoryBot.create(:game)
      piece1 = Pawn.create(position_x: 1, position_y: 2, color: "white", game_id: game.id)

      var = piece1.valid_move?(2,3)
      expect(var).to eq(false)
    end
  end

  describe "valid_move?" do
    it "should return false if pawn can not forward 2 spaces if enemy pawn at position" do
      game = FactoryBot.create(:game)
      piece1 = Pawn.create(position_x: 1, position_y: 2, color: "white", game_id: game.id)
      piece2 = Pawn.create(position_x: 1, position_y: 4, color: "black", game_id: game.id)

      var = piece1.valid_move?(1,4)
      expect(var).to eq(false)
    end
  end
  
  describe "valid_move?" do
    it "should return false if pawn is off board" do
      game = FactoryBot.create(:game)
      piece1 = Pawn.create(position_x: 1, position_y: 9, color: "white", game_id: game.id)

      var = piece1.valid_move?(1,10)
      expect(var).to eq(false)
    end
  end
  
  describe "valid_move?" do
    it "should return false if pawn can make diagonal capture" do
      game = FactoryBot.create(:game)
      piece1 = Pawn.create(position_x: 1, position_y: 2, color: "white", game_id: game.id)
      piece2 = Pawn.create(position_x: 2, position_y: 3, color: "white", game_id: game.id)
      
      var = piece1.valid_move?(2,3)
      expect(var).to eq(false)
    end
  end

  # Shows if the king and rook can castle
  describe "can_castle" do
    it "should return true if kings can castle" do
      game = FactoryBot.create(:game)
      king1 = King.create(position_y: 1, position_x: 5, color: "white", game_id: game.id)
      rook1 = Rook.create(position_y: 1, position_x: 1, color: "white", game_id: game.id)
      rook2 = Rook.create(position_y: 1, position_x: 8, color: "white", game_id: game.id)
      
      king2 = King.create(position_y: 8, position_x: 5, color: "black", game_id: game.id)
      rook3 = Rook.create(position_y: 8, position_x: 1, color: "black", game_id: game.id)
      rook4 = Rook.create(position_y: 8, position_x: 8, color: "black", game_id: game.id)


      test1 = king1.can_castle
      expect(test1).to eq([["kingside_castle", "white"],["queenside_castle", "white"]])
      test2 = king2.can_castle
      expect(test2).to eq([["kingside_castle", "black"],["queenside_castle", "black"]])
    end
  end

  describe "can_castle" do
    it "should return true if king can't castle with moved rook" do
      game = FactoryBot.create(:game)
      king1 = King.create(position_y: 1, position_x: 5, color: "white", game_id: game.id)
      rook2 = Rook.create(position_y: 1, position_x: 8, color: "white", game_id: game.id, moved: true)
      
      king2 = King.create(position_y: 8, position_x: 5, color: "black", game_id: game.id)
      rook3 = Rook.create(position_y: 8, position_x: 1, color: "black", game_id: game.id)
      rook4 = Rook.create(position_y: 8, position_x: 8, color: "black", game_id: game.id)

      test1 = king1.can_castle
      expect(test1).to eq([])
      test2 = king2.can_castle
      expect(test2).to eq([["kingside_castle", "black"],["queenside_castle", "black"]])
    end
  end
  
  describe "can_castle" do
    it "should return true if king can't castle after being moved" do
      game = FactoryBot.create(:game)
      king1 = King.create(position_y: 1, position_x: 5, color: "white", game_id: game.id, moved: true)
      rook1 = Rook.create(position_y: 1, position_x: 1, color: "white", game_id: game.id)
      rook2 = Rook.create(position_y: 1, position_x: 8, color: "white", game_id: game.id)
      
      king2 = King.create(position_y: 8, position_x: 5, color: "black", game_id: game.id)
      rook3 = Rook.create(position_y: 8, position_x: 1, color: "black", game_id: game.id)
      rook4 = Rook.create(position_y: 8, position_x: 8, color: "black", game_id: game.id)

      test1 = king1.can_castle
      expect(test1).to eq([])
      test2 = king2.can_castle
      expect(test2).to eq([["kingside_castle", "black"],["queenside_castle", "black"]])
    end
  end
  
  describe "can_castle" do
    it "should return true if king can't castle while in check" do
      game = FactoryBot.create(:game)
      king1 = King.create(position_y: 1, position_x: 5, color: "white", game_id: game.id)
      rook1 = Rook.create(position_y: 1, position_x: 1, color: "white", game_id: game.id)
      rook2 = Rook.create(position_y: 1, position_x: 8, color: "white", game_id: game.id)
      queen = Queen.create(position_y: 1, position_x: 4, color: "black", game_id: game.id)
      king2 = King.create(position_y: 8, position_x: 5, color: "black", game_id: game.id)
      rook3 = Rook.create(position_y: 8, position_x: 1, color: "black", game_id: game.id)
      rook4 = Rook.create(position_y: 8, position_x: 8, color: "black", game_id: game.id)

      test1 = king1.can_castle
      expect(test1).to eq([])
      test2 = king2.can_castle
      expect(test2).to eq([["kingside_castle", "black"],["queenside_castle", "black"]])
    end
  end

  describe "can_castle" do
    it "should return true if king can't castle into check" do
      game = FactoryBot.create(:game)
      king1 = King.create(position_y: 1, position_x: 5, color: "white", game_id: game.id)
      rook1 = Rook.create(position_y: 1, position_x: 1, color: "white", game_id: game.id)
      rook2 = Rook.create(position_y: 1, position_x: 8, color: "white", game_id: game.id)
      queen = Queen.create(position_y: 2, position_x: 2, color: "black", game_id: game.id)
      queen2 = Queen.create(position_y: 2, position_x: 6, color: "black", game_id: game.id)
      king2 = King.create(position_y: 8, position_x: 5, color: "black", game_id: game.id)
      rook3 = Rook.create(position_y: 8, position_x: 1, color: "black", game_id: game.id)
      rook4 = Rook.create(position_y: 8, position_x: 8, color: "black", game_id: game.id)

      test1 = king1.can_castle
      expect(test1).to eq([])
      test2 = king2.can_castle
      expect(test2).to eq([["kingside_castle", "black"],["queenside_castle", "black"]])

    end
  end
  
  describe "can_castle" do
    it "should return true if king can't castle though a check" do
      game = FactoryBot.create(:game)
      king1 = King.create(position_y: 1, position_x: 5, color: "white", game_id: game.id)
      rook1 = Rook.create(position_y: 1, position_x: 1, color: "white", game_id: game.id)
      rook2 = Rook.create(position_y: 1, position_x: 8, color: "white", game_id: game.id)
      queen = Queen.create(position_y: 2, position_x: 3, color: "black", game_id: game.id)
      queen2 = Queen.create(position_y: 2, position_x: 7, color: "black", game_id: game.id)
      king2 = King.create(position_y: 8, position_x: 5, color: "black", game_id: game.id)
      rook3 = Rook.create(position_y: 8, position_x: 1, color: "black", game_id: game.id)
      rook4 = Rook.create(position_y: 8, position_x: 8, color: "black", game_id: game.id)

      test1 = king1.can_castle
      expect(test1).to eq([])
      test2 = king2.can_castle
      expect(test2).to eq([["kingside_castle", "black"],["queenside_castle", "black"]])

    end
  end

  describe "castle!" do
    it "should return true if white kingside castle was successful" do
      game = FactoryBot.create(:game)
      king = King.create(position_y: 1, position_x: 5, color: "white", game_id: game.id)
      rook1 = Rook.create(position_y: 1, position_x: 8, color: "white", game_id: game.id) 
      var = king.castle!("kingside_castle","white")
      new_king = game.pieces.where(position_x: 7, position_y: 1)[0]
      new_rook = game.pieces.where(position_x: 6, position_y: 1)[0]
      old_king = game.pieces.where(position_x: 5, position_y: 1)[0]
      old_rook = game.pieces.where(position_x: 8, position_y: 1)[0]
      castle_test = [new_king.type, new_rook.type, old_king, old_rook]

      expect(castle_test).to eq(["King","Rook",nil,nil])
    end
  end

 describe "castle!" do
    it "should return true if white queenside castle was successful" do
      game = FactoryBot.create(:game)
      king = King.create(position_y: 1, position_x: 5, color: "white", game_id: game.id)
      rook1 = Rook.create(position_y: 1, position_x: 1, color: "white", game_id: game.id) 
      var = king.castle!("queenside_castle","white")
      new_king = game.pieces.where(position_x: 3, position_y: 1)[0]
      new_rook = game.pieces.where(position_x: 4, position_y: 1)[0]
      old_king = game.pieces.where(position_x: 5, position_y: 1)[0]
      old_rook = game.pieces.where(position_x: 1, position_y: 1)[0]
      castle_test = [new_king.type, new_rook.type, old_king, old_rook]

      expect(castle_test).to eq(["King","Rook",nil,nil])
    end
  end
  
  describe "castle!" do
    it "should return true if black kingside castle was successful" do
      game = FactoryBot.create(:game)
      king = King.create(position_y: 8, position_x: 5, color: "white", game_id: game.id)
      rook1 = Rook.create(position_y: 8, position_x: 8, color: "white", game_id: game.id) 
      var = king.castle!("kingside_castle","black")
      new_king = game.pieces.where(position_x: 7, position_y: 8)[0]
      new_rook = game.pieces.where(position_x: 6, position_y: 8)[0]
      old_king = game.pieces.where(position_x: 5, position_y: 8)[0]
      old_rook = game.pieces.where(position_x: 8, position_y: 8)[0]
      castle_test = [new_king.type, new_rook.type, old_king, old_rook]

      expect(castle_test).to eq(["King","Rook",nil,nil])
    end
  end

  describe "castle!" do
    it "should return true if black queenside castle was successful" do
      game = FactoryBot.create(:game)
      king = King.create(position_y: 8, position_x: 5, color: "black", game_id: game.id)
      rook1 = Rook.create(position_y: 8, position_x: 1, color: "black", game_id: game.id) 
      var = king.castle!("queenside_castle","black")
      new_king = game.pieces.where(position_x: 3, position_y: 8)[0]
      new_rook = game.pieces.where(position_x: 4, position_y: 8)[0]
      old_king = game.pieces.where(position_x: 5, position_y: 8)[0]
      old_rook = game.pieces.where(position_x: 1, position_y: 8)[0]
      castle_test = [new_king.type, new_rook.type, old_king, old_rook]

      expect(castle_test).to eq(["King","Rook",nil,nil])
    end
  end


  #checks if king is in check
 
  describe "is_in_check?" do
   it "should return false if king can be checked by it's own color" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 1, position_y: 1, color: "white", game_id: game.id)
     piece2 = Queen.create(position_x: 1, position_y: 3, color: "white", game_id: game.id)
     piece3 = Rook.create(position_x: 1, position_y: 3, color: "white", game_id: game.id)
     
     var = piece1.is_in_check?
     expect(var).to eq(false)
   end
  end

  describe "is_in_check?" do
   it "should return true if selected king is in check" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 2, position_y: 1, color: "white", game_id: game.id)
     piece3 = Rook.create(position_x: 2, position_y: 5, color: "black", game_id: game.id)
     
     var = piece1.is_in_check?
     expect(var).to eq(true)
   end
  end

  describe "is_in_check?" do
   it "should return true if move will take king out of check" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 2, position_y: 1, color: "white", game_id: game.id)
     piece3 = Rook.create(position_x: 2, position_y: 5, color: "black", game_id: game.id)
     
     var = piece1.is_in_check?(1,1)
     expect(var).to eq(false)
   end
  end

  #tests for checkmate

  describe "is_in_checkmate?" do
   it "should return true if king is in checkmate" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 1, position_y: 1, color: "white", game_id: game.id)
     piece2 = Queen.create(position_x: 1, position_y: 8, color: "black", game_id: game.id)
     piece3 = Queen.create(position_x: 2, position_y: 8, color: "black", game_id: game.id)
    
     var = piece1.is_in_checkmate?
     expect(var).to eq(true)
   end
  end

  describe "is_in_checkmate?" do
   it "should return false if king is in not checkmate" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 1, position_y: 1, color: "white", game_id: game.id)
     piece2 = Queen.create(position_x: 3, position_y: 8, color: "black", game_id: game.id)
     piece3 = Queen.create(position_x: 2, position_y: 8, color: "black", game_id: game.id)
    
     var = piece1.is_in_checkmate?
     expect(var).to eq(false)
   end
  end


  describe "is_in_checkmate?" do
   it "should return true if king is in checkmate" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 1, position_y: 1, color: "white", game_id: game.id)
     piece2 = Rook.create(position_x: 1, position_y: 8, color: "black", game_id: game.id)
     piece3 = Rook.create(position_x: 2, position_y: 8, color: "black", game_id: game.id)
    
     var = piece1.is_in_checkmate?
     expect(var).to eq(true)
   end
  end

  describe "is_in_checkmate?" do
   it "should return true if king is in checkmate" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 8, position_y: 8, color: "white", game_id: game.id, moved: true)
     piece2 = Rook.create(position_x: 7, position_y: 1, color: "black", game_id: game.id)
     piece3 = Rook.create(position_x: 8, position_y: 1, color: "black", game_id: game.id)
    
     var = piece1.is_in_checkmate?
     expect(var).to eq(true)
   end
  end

  describe "is_in_checkmate?" do
   it "should return true if king is in checkmate" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 1, position_y: 8, color: "white", game_id: game.id, moved: true)
     piece2 = Pawn.create(position_x: 1, position_y: 7, color: "white", game_id: game.id)

     piece3 = Queen.create(position_x: 3, position_y: 8, color: "black", game_id: game.id)
   
    
     var = piece1.is_in_checkmate?
     expect(var).to eq(true)
   end
  end

  describe "is_in_checkmate?" do
   it "should return true if king is in checkmate" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 1, position_y: 8, color: "white", game_id: game.id, moved: true)
     
     piece2 = King.create(position_x: 2, position_y: 6, color: "black", game_id: game.id)
     piece3 = Knight.create(position_x: 1, position_y: 6, color: "black", game_id: game.id)
     piece3 = Bishop.create(position_x: 7, position_y: 2, color: "black", game_id: game.id)
    
     var = piece1.is_in_checkmate?
     expect(var).to eq(true)
   end
  end

  describe "is_in_checkmate?" do
   it "should return true if king is in checkmate" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 8, position_y: 8, color: "black", game_id: game.id, moved: true)

     piece2 = King.create(position_x: 8, position_y: 6, color: "white", game_id: game.id)
     piece2 = Bishop.create(position_x: 5, position_y: 6, color: "white", game_id: game.id)
     piece3 = Bishop.create(position_x: 6, position_y: 6, color: "white", game_id: game.id)
    
     var = piece1.is_in_checkmate?
     expect(var).to eq(true)
   end
  end


  describe "is_in_checkmate?" do
   it "should return true if king is in checkmate" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 5, position_y: 8, color: "black", game_id: game.id, moved: true)

     piece2 = King.create(position_x: 7, position_y: 8, color: "white", game_id: game.id)
     piece2 = Knight.create(position_x: 3, position_y: 6, color: "white", game_id: game.id)
     piece3 = Knight.create(position_x: 6, position_y: 6, color: "white", game_id: game.id)
    
     var = piece1.is_in_checkmate?
     expect(var).to eq(true)
   end
  end

  describe "is_in_checkmate?" do
   it "should return true if king is in checkmate" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 8, position_y: 8, color: "black", game_id: game.id, moved: true)
     piece2 = Pawn.create(position_x: 8, position_y: 7, color: "black", game_id: game.id)

     piece2 = Bishop.create(position_x: 1, position_y: 2, color: "white", game_id: game.id)
     piece3 = Bishop.create(position_x: 2, position_y: 2, color: "white", game_id: game.id)
    
     var = piece1.is_in_checkmate?
     expect(var).to eq(true)
   end
  end

  # describe "is_in_checkmate?" do
  #  it "should return true if king is in checkmate" do
  #    game = FactoryBot.create(:game)
  #    piece1 = King.create(position_x: 2, position_y: 8, color: "white", game_id: game.id, moved: true)
     
  #    piece2 = King.create(position_x: 2, position_y: 6, color: "black", game_id: game.id)
  #    piece3 = Rook.create(position_x: 6, position_y: 8, color: "black", game_id: game.id)
    
  #    var = piece1.is_in_checkmate?
  #    expect(var).to eq(true)
  #  end
  # end

  describe "is_in_checkmate?" do
   it "should return true if king is in checkmate" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 8, position_y: 1, color: "white", game_id: game.id, moved: true)
     
     piece2 = King.create(position_x: 7, position_y: 3, color: "black", game_id: game.id)
     piece3 = Knight.create(position_x: 8, position_y: 3, color: "black", game_id: game.id)
     piece4 = Bishop.create(position_x: 6, position_y: 3, color: "black", game_id: game.id)
    
     var = piece1.is_in_checkmate?
     expect(var).to eq(true)
   end
  end

  describe "is_in_checkmate?" do
   it "should return fasle if king is in not checkmate" do
     game = FactoryBot.create(:game)
     piece1 = King.create(position_x: 8, position_y: 1, color: "white", game_id: game.id)
     
     piece2 = King.create(position_x: 7, position_y: 3, color: "black", game_id: game.id)
     piece3 = Knight.create(position_x: 8, position_y: 3, color: "black", game_id: game.id)
     piece4 = Bishop.create(position_x: 2, position_y: 3, color: "black", game_id: game.id)
    
     var = piece1.is_in_checkmate?
     expect(var).to eq(false)
   end
  end


  #tests for promotion
  describe "promotion(x,y, 'Queen)" do
   it "should promote when the pawn reaches the oposite row if it is empty" do
     game = FactoryBot.create(:game)
     piece1 = Pawn.create(position_x: 1, position_y: 7, color: "white", game_id: game.id)
     piece1.move_to!(1,8, "Queen")
     piece2 = game.pieces.where(position_x: 1, position_y: 8)[0]
 
     expect(piece2.type).to eq("Queen")
   end
  end

  describe "promotion(x,y, 'Queen')" do
   it "should promote when the pawn reaches the oposite row if it is empty" do
     game = FactoryBot.create(:game)
     piece1 = Pawn.create(position_x: 1, position_y: 7, color: "white", game_id: game.id)
     piece2 = Bishop.create(position_x: 2, position_y: 8, color: "black", game_id: game.id)
     piece1.move_to!(2,8, "Queen")
     piece3 = game.pieces.where(position_x: 2, position_y: 8)[0]
 
     expect(piece3.type).to eq("Queen")
   end
  end

  describe "promotion(x,y, 'Rook')" do
   it "should promote when the pawn reaches the oposite row if it is empty" do
     game = FactoryBot.create(:game)
     piece1 = Pawn.create(position_x: 1, position_y: 7, color: "white", game_id: game.id)
     piece2 = Bishop.create(position_x: 2, position_y: 8, color: "black", game_id: game.id)
     piece1.move_to!(2,8, "Rook")
     piece3 = game.pieces.where(position_x: 2, position_y: 8)[0]
 
     expect(piece3.type).to eq("Rook")
   end
  end

    describe "promotion(x,y, 'Bishop')" do
   it "should promote when the pawn reaches the oposite row if it is empty" do
     game = FactoryBot.create(:game)
     piece1 = Pawn.create(position_x: 1, position_y: 7, color: "white", game_id: game.id)
     piece2 = Bishop.create(position_x: 2, position_y: 8, color: "black", game_id: game.id)
     piece1.move_to!(2,8, 'Bishop')
     piece3 = game.pieces.where(position_x: 2, position_y: 8)[0]
 
     expect(piece3.type).to eq('Bishop')
   end
  end

  describe "promotion(x,y, 'Knight')" do
   it "should promote when the pawn reaches the oposite row if it is empty" do
     game = FactoryBot.create(:game)
     piece1 = Pawn.create(position_x: 1, position_y: 7, color: "white", game_id: game.id)
     piece2 = Bishop.create(position_x: 2, position_y: 8, color: "black", game_id: game.id)
     piece1.move_to!(2,8, 'Knight')
     piece3 = game.pieces.where(position_x: 2, position_y: 8)[0]
 
     expect(piece3.type).to eq('Knight')
   end
  end




  #tests for stalemate
  

end
