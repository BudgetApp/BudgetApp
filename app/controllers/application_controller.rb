class ApplicationController < ActionController::Base

  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :signed_in_user

  def signed_in_user
    unless signed_in?
      save_current_url
      redirect_to root_url
    end
  end
end
