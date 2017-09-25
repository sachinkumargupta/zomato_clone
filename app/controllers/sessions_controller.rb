class SessionsController < ApplicationController

  def new
    if logged_in?
      flash[:info] = "You are already logged in"
      redirect_to restaurants_path
    end
  end

  def create
    unless session[:user_id].present?
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or restaurants_path
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    else
      flash[:danger] = "You are already logged through an account"
      redirect_to restaurants_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def omni
    if session[:user_id].present?
      flash[:danger] = "You are already logged through an account"
      redirect_to root_url
    else
      auth = request.env["omniauth.auth"]
      session[:omniauth] = auth.except('extra')
      user = User.sign_in_from_omniauth(auth)
      session[:user_id] = user.id
      if log_in(user)
        redirect_to user_path(user)
      else
        redirect_to root_url
      end
    end
  end
end
