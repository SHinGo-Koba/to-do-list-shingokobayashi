module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def log_in?
    !session[:user_id].nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def correct_user?(user)
    user == current_user
  end
  
  def need_to_login
    if !log_in?
      respond_to do |f|
        f.html{ redirect_to login_path }
        f.js{ render js: "window.location = '#{login_path}'" }
      end
      flash[:danger] = "Please login"
    end
  end
  
end
