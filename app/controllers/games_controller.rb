class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def create
    @number = params["number"].to_i
  end

  def show
    @game = Game.find(params[:id])
  end

end
