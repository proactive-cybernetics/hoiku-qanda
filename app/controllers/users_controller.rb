class UsersController < ApplicationController
  before_action :require_login, only: [:home]
  before_action :require_same_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params_create)
    user_defaults!
    
    if @user.save
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    if @current_user.update_attributes(user_params_update)
      redirect_to home_path, success: '更新が完了しました'
    else
      redirect_to edit_user_path, danger: '更新に失敗しました。必須項目を確認してください'
    end
  end

  def home
  end
  
  private
  def user_params_create
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_params_update
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :title_setting)
  end
  
  def require_same_user
    require_same_user_id(params[:id])
  end
  
  def user_defaults!
    @user.title = ""          # 称号なし
    @user.title_setting = 1   # 称号を表示する (デフォルト)
    @user.admin_auth = 0      # 管理者権限なし
  end
end
