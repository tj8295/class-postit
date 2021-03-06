class CommentsController < ApplicationController
  before_action :require_user

  def create
    # @post = Post.find(params[:post_id])
    @post = Post.find_by(slug: params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.creator = current_user
    @post.comments << @comment


    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    # @comment = Comment.find(params[:id])
    @comment = Comment.find(params[:id])
    @vote = Vote.create(vote: params[:vote], voteable:@comment, creator: current_user)

    if @vote.valid?
      flash[:notice] = "Your vote has been recorded."
    else
      flash[:error] = "You can only vote once."
    end

    redirect_to :back
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
