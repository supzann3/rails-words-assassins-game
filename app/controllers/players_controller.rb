class PlayersController < ApplicationController

  def index
    @players = Player.all.sort_by {|player| player.name}
  end

  def new
    title = params["title"]
    @game_id = Game.create({name: title}).id
    @number = params["number"].to_i
  end

  def delete
    player_id = params['player']['id'].to_i
    game_id = params['game']['id'].to_i
    Player.find(player_id).confirm_death
    redirect_to "/games/#{game_id}"
  end

end
