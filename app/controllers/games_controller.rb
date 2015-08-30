class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def create
    @number = params["number"].to_i
  end

  def show
    @players = Game.find(:id).all 
  end

end
