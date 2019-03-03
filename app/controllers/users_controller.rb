class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
  end

  def my_friends
    @friendships = current_user.friends
  end

  def search
    if params[:user_finder].blank?
      flash.now[:danger] = "You have entered an empty search string"
    else
      @friends = User.universe_user_search(params[:user_finder])
      @friends = current_user.exept_current_user(@friends)
      flash.now[:danger] = "No users meet this search criteria" if @friends.blank?
    end
    respond_to do |format|
      format.js {render partial: 'friends/result'}
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def add_friend
    @new_friend = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id])
    if @new_friend.save
      flash[:success] = "You have successfully added a friend."
    else
      flash[:danger] = "There was something wrong with your entry, please try later"
    end
    redirect_to my_friends_path
  end
end
