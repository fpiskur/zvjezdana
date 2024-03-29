module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
    # Guard against session replay attacks
    session[:session_token] = user.session_token
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logged_in?
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      if user && session[:session_token] == user.session_token
        user == User.find_by(username: admin_username)
      end
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        user == User.find_by(username: admin_username)
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
    user = User.find_by(username: admin_username)
    forget(user)
    reset_session
  end

  def admin_username
    Rails.application.credentials.username
  end
  
end
