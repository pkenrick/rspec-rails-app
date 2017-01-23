class ActivationsMailer < ApplicationMailer

  def activation_email(user)
    @user = user
    mail to: @user.email, subject: "Account Activation"
  end
end
