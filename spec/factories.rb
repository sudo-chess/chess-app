FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "sampleEmails#{n}@gmail.com"
    end
    # sequence(:white_player_id) { |n| n}
    # sequence(:black_player_id) { |n| n}
    password "secretPassword"
    password_confirmation "secretPassword"
  end


  factory :game do 
    # first_name 'John' 
    # sequence(:name) { |n| "user#{n}" }
    # sequence(:email) { |n| "fake#{n}@gamail.com"}

    user1 = FactoryBot.create(:user)
    user2= FactoryBot.create(:user)
    white_player_id user1.id
    black_player_id user2.id


    # sequence(:white_player_id) { |n| n}
    # sequence(:black_player_id) { |n| n}
    # association :user
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