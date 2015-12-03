class CommentsController  < ApplicationController

  def create
    #    puts params
    @post = Post.find params[:post_id]
    @post.comments.create(comments_attributes)
    redirect_to @post
  end

  private
  def comments_attributes
    params.require(:comment).permit(:body)
  end
end
