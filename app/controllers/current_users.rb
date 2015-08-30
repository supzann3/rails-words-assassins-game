class CurrentUsersController < ApplicationController

  def new
      CurrentUser.new({email: params[email]})
      redirect_to 'games/new'
  end

end
