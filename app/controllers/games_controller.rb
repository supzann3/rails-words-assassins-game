class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def delete
    @number = params["number"].to_i
  end

end
