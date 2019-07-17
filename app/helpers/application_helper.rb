module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id], deletion_flg: 0)
  end

  def logged_in?
    !current_user.nil?
  end
  
  def require_login
    if !logged_in?
      redirect_to root_path, success: 'ログインしてください'
    end
  end
  
  # ログインしているユーザーのIDと、パラメータのユーザーIDが
  # 同一であるか、管理者であればそのまま通す。
  # 別のユーザーID、かつ管理者でなければユーザーホームページにリダイレクト
  def require_same_user_id(id)
    require_login
    if id.to_i != @current_user.id and @current_user.admin_auth == 0
      redirect_to home_path, danger: '他のユーザーのプロフィール編集はできません'
    end
  end
end
