class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
  binding.pry
    @post = Post.new(post_params)
    # binding.pry
    @post.creator = User.first
    if @post.save
      flash[:notice] = "Post created"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end


  def update
    binding.pry
    if @post.update(post_params)
      flash[:notice] = "The post was updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end





  # def update
  #   if @post.update(post_params)
  #     flash[:notice] = "The post was updated"
  #     redirect_to posts_path
  #   else
  #     render :edit
  #   end
  # end

  private

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end

  # def post_params
  #   # params.require(:post).permit(:title, :url, :creator)
  #   # if user.admin?
  #     params.require(:post).permit!
  #   # else
  #   #   params.require(:post).permit(:title, :url)
  # end

  def set_post
    @post = Post.find(params[:id])
  end
end
