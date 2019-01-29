class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @user = User.find_by(name: params[:session][:name])
    
    respond_to do |f|
      if @user && @user.authenticate(params[:session][:password])
        log_in @user
        f.html { redirect_to user_path(@current_user.id), notice: "Login successfully" }
      else
        f.html { render :new, notice: "Invalid name or password" }
      end
    end
  end
  
  def destroy
  end
  
end
