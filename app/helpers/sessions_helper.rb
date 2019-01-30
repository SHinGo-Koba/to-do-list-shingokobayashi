module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
    current_user
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
  
end
