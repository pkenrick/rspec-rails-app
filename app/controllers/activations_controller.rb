class ActivationsController < ApplicationController

  def activate
    user = User.find_by(id: params[:id])
    if user && user.authenticate_activation_token(params[:activation_token]) && user.activation_sent_at > 2.days.ago
      user.activate
      flash[:success] = "Your account has now been activated."
      login(user)
      remember(user)
      redirect_to user
    else
      flash[:danger] = "Sorry, your activation link was invalid or expired."
      redirect_to new_user_path
    end
  end

end
