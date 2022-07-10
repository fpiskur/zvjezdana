class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
    else
      flash.now[:danger] = "Korisničko ime i/ili lozinka nisu ispravni!"
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end
end
