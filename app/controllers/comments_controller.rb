class CommentsController < ApplicationController
  
  before_action :user_authenticated

  def user_authenticated
    if !user_signed_in?
      return redirect_to index_path
    end
  end

  def new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to @commentable, notice: "Comment was successfully posted."
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

end
