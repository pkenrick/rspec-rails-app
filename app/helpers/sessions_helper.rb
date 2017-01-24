module SessionsHelper

  def login(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.create_remember_token
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    puts "==== In the current user method ===="
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    else cookies.signed[:user_id]
      puts "==== In the right pat of the current_user method ===="
      puts "==== the user ID in the cookies is: #{cookies.signed[:user_id]} ===="
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticate_token(cookies[:remember_token], "remember")
        login(user)
        @current_user = user
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def log_out
    forget(current_user)
    session[:user_id] = nil
  end

  def forget(user)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    user.forget
  end

end
