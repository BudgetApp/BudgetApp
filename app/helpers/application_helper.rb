module ApplicationHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent.signed[:remember_token] = remember_token
    user.update(:remember_token => User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !!current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user ||= user
  end

  def current_user
    remember_token = User.encrypt(cookies.signed[:remember_token])
    @current_user ||= User.find_by(:remember_token => remember_token)
  end

  def save_current_url
    cookies.signed[:requested_url] = {
      value: request.url,
      expires: 5.minutes.from_now
    }
  end

  def requested_url
    url = cookies.signed[:requested_url]
    cookies.delete(:requested_url)
    url || user_path
  end

end
