class PostsController < ApplicationController
  def index
    @posts = Post.all
    # render 'posts/index'
   end

  def show

    @post = Post.find(params[:id])
     # binding.pry
  end

  def new

  end

  def create

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update

  end
end
