class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.find(params[:id])
  end

  def show
    puts params
  end
end
