class User::HomesController < ApplicationController

  def top
    @posts = Post.order(created_at: :desc).page(params[:page]).per(5)
  end

end
