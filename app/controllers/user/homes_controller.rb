class User::HomesController < ApplicationController
  
  def top
    @posts = Post.all.page(params[:page]).per(5)
  end 
  
end
