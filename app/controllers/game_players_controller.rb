class GamePlayersController < ApplicationController

  # def new
  #   @number = params["number"].to_i
  # end

  def new
    byebug
    id = params['game']['id']
    Game.find(id).start(params)
    redirect '/games/show/#{id}'
  end

end
