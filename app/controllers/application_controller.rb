class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?




  def current_user
    # if there's authenticated user, reutrn the user obj
    # else return nil

    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # makes one db call per webpage request to see if logged in, won't make it more than once becauseof memoization.

    # user = User.find(session[:user_id])
    # if user
    #   return user
    # else
    #   return nil
    # end
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You need to be logged in to do this."
      redirect_to root_path
    end
  end

  def require_admin
    # if !logged_in? || !current_user.admin?
    access_denied unless logged_in? and current_user.admin?
  end

  def access_denied
    flash[:error] = "Must be admin for that"
    redirect_to :back
  end

end
