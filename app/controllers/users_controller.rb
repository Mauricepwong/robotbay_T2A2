class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def destroy
    @user = current_user
    @user.destroy

    if @user.destroy
        redirect_to root_url, flash[:notice] = 'Bye! Your account has been successfully cancelled. We hope to see you again soon.'
    end
  end
end
