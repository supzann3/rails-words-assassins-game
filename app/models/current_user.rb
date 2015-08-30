class CurrentUser < ActiveRecord::Base

  def is_a_player(game)
    result = false
    game.players.each do |player|
      result = true if player.email == self.email
    end
    result
  end

end
