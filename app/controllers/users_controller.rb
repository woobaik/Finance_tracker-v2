class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
  end

  def my_friends
    @friendships = current_user.friends
  end

  def search
    @friends = User.universe_user_search(params[:user_finder])
    puts @friends
    render json: @friends
  end
end
