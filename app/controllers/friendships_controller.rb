class FriendshipsController < ApplicationController
  def destroy
    @deleting_relationship = Friendship.where(user_id: current_user.id, friend_id: params[:id]).first
    username = User.find_by_id(params[:id]).full_name
    if @deleting_relationship.destroy
      flash[:success] = "Successfully removed #{username} from your list"
    else
      flash[:danger] = "Something wrong with your request, please try it later"
    end
    redirect_to my_friends_path
  end
end
