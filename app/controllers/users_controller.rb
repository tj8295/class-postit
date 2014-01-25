class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_user, only: [:update, :edit]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    binding.pry
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "User saved"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    # binding.pry
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
      params.require(:user).permit(:username, :password, :time_zone)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_same_user
      if current_user != @user
        flash[:error] = "You can only edit your own profile."
        redirect_to root_path
      end
    end
end
