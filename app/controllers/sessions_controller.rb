class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      if params[:session][:remember_me] == '1' 
        remember(user)
      else
        forget(user)
      end
      flash[:success] = 'ログインしました。'
      redirect_to root_url
    else
      flash[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    if logged_in?
      forget(current_user)
      session[:user_id] = nil
      flash[:success] = 'ログアウトしました。'
      redirect_to root_url
    end
  end
  
end
