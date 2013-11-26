class FriendshipsController < ApplicationController

  def new
    friend = User.find_by(friendship_params)
    current_user.add_friend(friend)
    redirect_to user_path(current_user)
  end

  private
    def friendship_params
      params.require(:friendship).permit(:id)
    end

end