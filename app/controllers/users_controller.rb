class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:success] = 'ご登録していただいたメールアドレスにアカウント有効化メールを送信しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を変更しました。"
      redirect_to user_url(@user)
    else
      flash[:danger] = "変更に失敗しました。"
      render :edit
    end
  end
  
  def destroy_confirmation
    @user = current_user
  end
  
  def destroy
    @user = User.find(params[:id])
    
    @user.destroy
    
    flash[:success] = "退会しました。"
    redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
