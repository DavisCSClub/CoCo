class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.create(user_params)
    if params[:team_id][:team_id].empty?
      @user.create_team(team_params)
    else
      @user.team = Team.find(params[:team_id][:team_id])
    end
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email)
  end

  def team_params
    params.require(:team).permit(:name, :password)
  end
end
