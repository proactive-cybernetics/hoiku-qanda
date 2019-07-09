class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.title = ""          # 称号なし
    @user.title_setting = 1   # 称号を表示する (デフォルト)
    @user.admin_auth = 0      # 管理者権限なし
    
    if @user.save
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def home
    if !logged_in?
      redirect_to root_path, success: 'ログインしてください'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
