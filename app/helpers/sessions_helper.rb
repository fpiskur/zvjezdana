module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logged_in?
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      user == User.find_by(username: "zvjezdana")
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        user == User.find_by(username: "zvjezdana")
      end
    end
  end

  # Forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    user = User.find_by(username: "zvjezdana")
    forget(user)
    reset_session
  end
end
