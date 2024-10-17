class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(3)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_top_path
  end

end
