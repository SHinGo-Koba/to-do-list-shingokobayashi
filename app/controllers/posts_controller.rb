class PostsController < ApplicationController
  before_action :need_to_login

  def create
    @post = Post.new(post_params)
    
    respond_to do |format|
      if @post.save
        format.js
      else
        flash.now[:danger] = "Failed to post"
      end
    end
  end
  
  def destroy
  
  end
  
  private
    def post_params
      params.require(:post).permit(:content, :due).merge(user_id: current_user.id)
    end
end
