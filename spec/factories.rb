FactoryBot.define do
  
  factory :user do
    sequence :email do |n|
      "sampleEmails#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :game do 
  association :white_player, factory: :user
  association :black_player, factory: :user
  # next_player_to_move :white_player, factory: :user
  end

end