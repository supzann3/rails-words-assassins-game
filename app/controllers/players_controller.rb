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
    player_id = params['player']['id']
    game_id = params['game']['id']
    Player.find(id).dies
    redirect "/games/#{id}/show"
  end

end
