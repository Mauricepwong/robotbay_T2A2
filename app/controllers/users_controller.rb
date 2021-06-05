class UsersController < ApplicationController
  before_action :authenticate_user!

  # Sets the user before dispaying the profile page. 
  def show
    @user = current_user
  end
end
