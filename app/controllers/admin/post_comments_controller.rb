class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end
end
