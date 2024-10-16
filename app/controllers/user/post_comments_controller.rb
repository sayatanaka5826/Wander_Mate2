class User::PostCommentsController < ApplicationController
  before_action :authenticate_user!

def create
  @post= Post.find(params[:post_id])
  @comment = current_user.post_comments.new(post_comment_params)
  @comment.post_id = @post.id
  @comment.save
  redirect_to request.referer
end

def destroy
  @comment = PostComment.find(params[:id])
  @comment.destroy
  redirect_to request.referer
end


private

def post_comment_params
  params.require(:post_comment).permit(:body)
end


end
