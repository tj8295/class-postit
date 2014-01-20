class UsersController < ApplicationController
  before_action :require_user, only: [:update, :edit]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User saved"
      redirect_to '/posts'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def activate
    binding.pry
    user = User.find_by token: params[:token]
    if user
      user.update_attribute('status', 'active')
      user.token = nil
      user.save
    end
  end


  private
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
