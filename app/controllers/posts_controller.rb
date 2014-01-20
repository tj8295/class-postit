class PostsController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :set_post, only: [:edit, :show, :update, :vote]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse.take(15)
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      flash[:notice] = "Post created".html_safe
      redirect_to posts_path
    else
      render :new
    end
  end

  def vote
    @post = Post.find(params[:id])
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    # if @vote.valid? && !
    if !@vote.errors.any?
      flash[:notice] = "Your vote was counted."
    else
      flash[:error] = "You can only vote for that once."
    end

    redirect_to :back
  end

  def edit; end


  def update
    if @post.update(post_params)
      flash[:notice] = "The post was updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
