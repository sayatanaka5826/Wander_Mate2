class Admin::PostsController < ApplicationController
  
  def index
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def destroy
  end


end
