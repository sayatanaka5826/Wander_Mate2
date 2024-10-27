class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "ユーザー"
      @users = User.where("name LIKE ?", "%#{@word}%").order(created_at: :desc).page(params[:page]).per(10)
    elsif @range == "投稿"
      @posts = Post.where("title LIKE ?","%#{@word}%").order(created_at: :desc).page(params[:page]).per(10)
    end
  end

end
