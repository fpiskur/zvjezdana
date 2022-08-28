class SessionsController < ApplicationController

  before_action :logged_in_user, only: [:destroy]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.username == admin_username && user.authenticate(params[:session][:password])
      reset_session
      remember user
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] = "Korisničko ime i/ili lozinka nisu ispravni!"
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
