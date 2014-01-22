class CommentsControllerC < ApplicationController
  def create
    # binding.pry
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = post
    # @comment = @post.comments.new(params.require(:comment).permit(:body))
    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'post/show'
    end
  end

  private
    def post_params
      params.require(:comment).permit!
    end
end
