class PostsController < ApplicationController
  before_action :need_to_login

  def create
    @post = Post.new(post_params)
    
    respond_to do |f|
      if @post.save
        f.js
      else
        flash.now[:danger] = "Failed to post"
      end
    end
  end
  
  def destroy
  
  end
  
  private
    def post_params
      params.require(:post).permit(:content).merge(user_id: current_user.id)
    end
end
