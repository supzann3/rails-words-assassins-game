class PlayersController < ApplicationController

  def index
    @players = Player.all.sort_by {|player| player.name}
  end

  def new
    title = params["title"]
    @game_id = Game.create({name: title}).id
    @number = params["number"].to_i
  end

  def destroy
    id = params['player']['id']
    Player.find(id).dies
    redirect '/players/index'
  end

end
