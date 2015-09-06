class UsersController < ApplicationController
  before_action :all_users, only: [:create, :index]

  def new
    @user = User.new
    @team = Team.new
    respond_to do |format| 
      format.html
      format.js
    end
  end

  def create
    byebug
    if !params[:team].nil?
      @team = Team.create(team_params)
      @team.users.create(user_params)
    else 
      @team = Team.find(params[:user][:team])
      @user = Team.users.create(user_params)
    end

    respond_to do |format| 
      format.html { redirect_to users_path }
      format.js
    end
  end

  private 

    def all_users
      @users = User.all
    end

    def team_params
      params.require(:team).permit(:name, :password)
    end

    def user_params 
      params.require(:user).permit(:name, :email)
    end
end
