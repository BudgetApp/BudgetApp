class SessionsController < ApplicationController
  skip_before_action :signed_in_user, only: [:create, :destroy]

  def create
    hashed_uid = Digest::SHA1.hexdigest(auth_hash.uid)
    @user = User.find_or_initialize_by(provider: auth_hash.provider, uid: auth_hash.uid, hashed_uid: hashed_uid, username: auth_hash.extra.raw_info.username)
    @user.info = auth_hash.info.to_hash
    @user.name = auth_hash.info.name
    if @user.new_record? && auth_hash.info.email
      @user.email = auth_hash.info.email
    end
    if @user.save
      self.sign_in(@user)
      redirect_to requested_url
    else
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    redirect_to '/'
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end
end
