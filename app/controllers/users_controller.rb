class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
  end

  def my_friends
    @friendships = current_user.friends
  end

  def search
    if params[:user_finder].blank?
      flash.now[:danger] = "You have entered on empty search string"
    else
      @friends = User.universe_user_search(params[:user_finder])
      flash.now[:danger] = "No users meet this search criteria" if @friends.blank?
    end
    respond_to do |format|
      format.js {render partial: 'friends/result'}
    end
  end
end
