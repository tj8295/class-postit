class UsersController < ApplicationController
  def activate
    binding.pry
    user = User.find_by token: params[:token]
    if user
      user.update_attribute('status', 'active')
      user.token = nil
      user.save
    end
  end
end
