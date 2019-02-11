class SessionsController < ApplicationController
  before_action :need_to_login, only: :destroy
  
  def new
  end
  
  def create
    @user = User.find_by(name: params[:session][:name])
    
    respond_to do |f|
      if @user && @user.authenticate(params[:session][:password])
        log_in @user
        flash[:success] = "Login successfully"
        f.html { redirect_to user_path(current_user.id) }
      else
        flash.now[:danger] = "Invalid name or password"
        f.html { render :new }
      end
    end
  end
  
  def destroy
    respond_to do |f|
      session[:user_id] = nil
      @current_user = nil
      flash[:success] = "Logout successfully" 
      f.html { redirect_to login_path }
    end
  end
  
end
