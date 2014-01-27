class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
      # binding.pry
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_to_twilio
        #send pin to twilio, #sms to users phone

        #show pin form
        redirect_to pin_path

      else
        login_success(user)
      end
        #redirect
    else
      flash.now[:error] = "There is something wrong with your username or password."
      render :new
    end
  end

  def pin
    access_denied if session[:two_factor].nil?
    if request.post?
      session[:two_factor] = nil
      user = User.find_by(pin: params[:pin])
      # binding.pry
      if user
        user.remove_pin!
        login_success(user)

      else
        flash[:error] = "Incorrect Pin"
        redirect_to login_path
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to root_path
  end

  private
    def login_success(user)
      session[:user_id] = user.id
      flash[:notice] = "You've logged in!"
      redirect_to root_path
    end
end
