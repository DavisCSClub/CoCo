class UsersController < ApplicationController
  before_action :all_users, only: [:create, :index]

  def new
    @user = User.new
    respond_to do |format| 
      format.html
      format.js
    end
  end

  def create
    @user = User.create(user_params)

    respond_to do |format| 
      format.html
      format.js
    end
  end

  private 

    def all_users
      @users = User.all
    end

    def user_params 
      params.require(:user).permit(:name, :email)
    end
end
