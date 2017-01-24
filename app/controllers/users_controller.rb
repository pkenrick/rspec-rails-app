class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.create_activation_token
      login(@user)
      remember(@user)
      flash[:success] = "Welcome! You have signed up.  Please check your email for a activation link."
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Sorry, there was a problem with your information."
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
