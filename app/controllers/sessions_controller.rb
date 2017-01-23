class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      login(user)
      remember(user)
      flash[:success] = "Welcome.  You have been logged in!"
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = "Sorry.  Your email or password were invalid."
      render "new"
    end
  end

  def destroy
    if logged_in?
      log_out
      flash[:success] = "Goodbye.  You have been logged out!"
    end
    redirect_to new_session_path
  end
end
