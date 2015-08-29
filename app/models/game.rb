class Game < ActiveRecord::Base
  belongs_to :game_player
  has_many :games, through: game_player
end
