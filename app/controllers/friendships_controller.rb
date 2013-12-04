class FriendshipsController < ApplicationController

  def new
    friendship_params[:friend_id].each do |friend_id|
      friend = User.find(friend_id)
      current_user.add_friend(friend) if friend
    end

    redirect_to user_path(current_user)
    # friend = User.find_by(friendship_params)
    # current_user.add_friend(friend)
    # redirect_to user_path(current_user)
  end

  def accept
    Friendship.find_by(friendship_params).accept_friendship
    redirect_to user_path(current_user)
  end

  private
    def friendship_params
      params.require(:friendship).permit(:id, :friend_id => [])
    end

end