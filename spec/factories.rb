FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  # factory :game do
    # game = Game.create(white_player_id: 1, black_player_id: 2)

    # or
    # game = Game.new

    # piece1 = Piece.create(position_x: 7, position_y: 7, game_id: game.id)
    # piece2 = Piece.create(position_x: 7, position_y: 5, game_id: game.id)
    # piece3 = Piece.create(position_x: 2, position_y: 2, game_id: game.id)
    # game.pieces << piece1 << piece2 << piece3
  # end


end