module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      user == User.find_by(username: "zvjezdana")
    end
  end

  def log_out
    reset_session
  end
end
