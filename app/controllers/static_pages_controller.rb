class StaticPagesController < ApplicationController
  skip_before_action :signed_in_user, only: [:index]

  def index
    redirect_to user_url if signed_in?
  end
end
