class UsersController < ApplicationController
  # ユーザーホームページの表示と、ユーザー情報ページの表示,
  # 退会ページの表示にはログインが必要
  before_action :require_login, only: [:home, :show, :resign]
  
  # ユーザー情報編集ページの表示と、ユーザー情報の更新,
  # 退会の実行はログインしている本人
  # または管理者のみ行える
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  PER = 5
  
  # ユーザー新規登録画面を表示
  def new
    @user = User.new
  end
  
  # ユーザーをデータベースに新規登録
  def create
    @user = User.new(user_params_create)
    set_user_defaults!  # @userのカラムにデフォルト値を追加
    
    if @user.save
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  # ユーザー情報編集ページを表示
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  # ユーザー情報を更新
  def update
    @user = User.find_by(id: params[:id])

    if @current_user.admin_auth != 0
      # 管理人による更新の場合はパスワード入力不要
      if @user.update_columns(user_params_update_admin.to_h)
        redirect_to user_path, success: '更新が完了しました'
      else
        redirect_to edit_user_path, danger: '更新に失敗しました。'
      end
    else
      if @user.update_attributes(user_params_update)
        redirect_to home_path, success: '更新が完了しました'
      else
        redirect_to edit_user_path, danger: '更新に失敗しました。必須項目を確認してください'
      end
    end
  end

  # ユーザーホームページを表示
  def home
  end
  
  # ユーザープロフィールを表示
  def show
    @user = User.find_by(id: params[:id])
  end
  
  # 退会ページを表示
  def resign
    @user = User.find_by(id: @current_user.id)
  end
  
  # 退会処理を実施
  def destroy
    user_deletion = {
      name: "退会したユーザー",
      profile: "このユーザーは退会しています",
      image: "",
      title: "",
      admin_auth: 0,
      deletion_flg: 1
    }
    if @current_user.admin_auth != 0
      # 管理人による強制退会ではパスワード入力は不要
      @user = User.find_by(id: params[:id])
      if @user.update_columns(user_deletion)
        redirect_to home_path, success: 'ユーザーを強制退会させました'
      else
        redirect_to user_path(@user.id), danger: 'ユーザーの強制退会に失敗しました'
      end
    else
      user_deletion[:password] = params[:user][:password]
      user_deletion[:password_confirmation] = params[:user][:password_confirmation]
      if @current_user.update_attributes(user_deletion)
        log_out
        redirect_to root_path, success: '退会処理が完了しました'
      else
        redirect_to resign_user_path, danger: '退会処理が行えませんでした'
      end
    end
  end
  
  # ユーザー一覧を表示
  def index
    @users = User.all.where(deletion_flg: 0).page(params[:page]).per(PER)
  end

  private
  def user_params_create
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_params_update
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :title_setting, :profile)
  end
  
  def user_params_update_admin
    params.require(:user).permit(:name, :email, :title_setting, :profile)
  end

  def require_same_user
    require_same_user_id(params[:id])
  end
  
  def set_user_defaults!
    @user.title = ""          # 称号なし
    @user.title_setting = 1   # 称号を表示する (デフォルト)
    @user.admin_auth = 0      # 管理者権限なし
    @user.deletion_flg = 0    # 削除済みフラグ無効
  end
end
