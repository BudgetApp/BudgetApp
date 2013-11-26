class FriendshipsController < ApplicationController

  def new
    # Right now, this is stupid and ID refers to a friend's id
    friend = User.find_by(friendship_params)
    current_user.add_friend(friend)
    redirect_to user_path(current_user)
  end

  def accept
    Friendship.find_by(friendship_params).accept_friendship
    redirect_to user_path(current_user)
  end

  private
    def friendship_params
      params.require(:friendship).permit(:id)
    end

end