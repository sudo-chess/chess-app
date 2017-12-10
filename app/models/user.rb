class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :challenging_games, foreign_key: "white_player_id",:class_name => Game

  has_many :challenged_games, foreign_key: "black_player_id", :class_name => Game


  def all_games
    Game.where("white_player_id = ? OR black_player_id = ?", self.id, self.id)
  end

  def name
    self.email
  end
end
