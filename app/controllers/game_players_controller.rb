class GamePlayersController < ApplicationController

  # def new
  #   @number = params["number"].to_i
  # end

  def new
    # byebug
    id = params['game']['id']
    @game = Game.find(id).start(params)
    @id = id
    redirect_to "/games/#{id}"
  end

end
