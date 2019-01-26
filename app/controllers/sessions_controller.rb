class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(name: params[:sesssion][:name])
  end
  
  def destroy
  end
  
end
