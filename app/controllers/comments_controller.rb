class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.creator = User.first #TODO: fix after authentication
    @post.comments << @comment


    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end


  # def create
  #   # binding.pry
  #   @post = Post.find(params[:post_id])
  #   @comment = Comment.new(comment_params)
  #   @comment.creator = User.first
  #   @comment.post = @post
  #   if @comment.save
  #     flash[:notice] = "Comment saved"
  #     redirect_to post_path(@post)
  #   else
  #     render 'posts/show'
  #   end
  # end


  # private
  #   def comment_params
  #     params.require(:comment).permit(:body)
  #   end

end
