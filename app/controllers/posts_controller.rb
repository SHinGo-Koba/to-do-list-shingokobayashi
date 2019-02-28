class PostsController < ApplicationController
  before_action :need_to_login
  respond_to :js
  
  def create
    @post = Post.new(post_params)
    if @post.save
      @posts = Post.where(user_id: current_user.id).order(due: :asc)
      flash.now[:success] = "Posted successfully"
    else
      flash.now[:danger] = "Failed to post"
    end
  end
  
  def destroy
  
  end
  
  private
    def post_params
      params.require(:post).permit(:content, :due).merge(user_id: current_user.id)
    end
end
