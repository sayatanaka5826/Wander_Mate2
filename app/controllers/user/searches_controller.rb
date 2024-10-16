class User::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "ユーザー"
      @users = User.where("name LIKE ?","%#{@word}%").page(params[:page]).per(3)
    elsif @range == "投稿"
      @posts = Post.where("title LIKE ?","%#{@word}%").page(params[:page]).per(3)
    end
  end


end
