class User::PostsController < ApplicationController
before_action :authenticate_user!, except: [:show]
before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:post_success] = "投稿されました"
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
    flash[:post_edit_success] = "投稿が更新されました"
    redirect_to post_path
    else
    render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:post_destroy_success] = "投稿が削除されました"
    redirect_to root_path
  end



  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end

  def is_matching_login_user
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to root_path
    end
  end

end
