class UsersController < ApplicationController
  def new
    # Cannot create a new user without a team to associate it with
    # Modify new team path to show error message in this case
    redirect_to new_team_path, alert: "No Teams exist yet!" if Team.all.length == 0
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      redirect_to new_user_path, alert: "User creation failed :("
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email)
  end
end
