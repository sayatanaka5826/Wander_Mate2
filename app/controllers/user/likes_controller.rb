class User::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: @post.id)
    @like.save
    @like.errors.full_messages
    # redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post_id: post.id)
    @like.destroy
    @post = @like.post
    # redirect_to request.referer
  end


  def authenticate_user!
    unless user_signed_in?
      redirect_to new_user_session_path, alert: 'ログインしてください。'
    end
  end

end
