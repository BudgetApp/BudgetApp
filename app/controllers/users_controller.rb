class UsersController < ApplicationController

  before_action :set_user

  def feed
  end

  def show
  end

  def add_friends
  end

  private
  def set_user
    @user = current_user
  end

end
