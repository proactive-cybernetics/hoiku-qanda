module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
  
  def require_login
    if !logged_in?
      redirect_to root_path, success: 'ログインしてください'
    end
  end
  
  def require_same_user_id(id)
    require_login
    if id.to_i != session[:user_id]
      redirect_to home_path, danger: '他のユーザーのプロフィール編集はできません'
    end
  end
end
