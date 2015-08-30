class CurrentUsersController < ApplicationController
  def new
    CurrentUser.create({email: params["email"]})
    redirect_to games_new_path
  end
end
