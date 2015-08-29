class PlayersController < ApplicationController

  def index
    @players = Player.all.sort_by {|player| player.name}
  end

  def destroy
    id = params['player']['id']
    Player.find(id).dies
    redirect '/players/index'
  end

end
