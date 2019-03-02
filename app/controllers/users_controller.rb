class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
  end

  def my_friends
    @friendships = current_user.friends
  end
end
