class UsersController < ApplicationController
  before_action :all_users, only: [:create, :index]

  def new
    if !logged_in
      @user = User.new
      @team = Team.new
      respond_to do |format| 
        format.html
        format.js
      end
    else
      flash[:error] = "You are already logged in"
      redirect_to root_path
    end
  end

  def create
    flash[:validation_errors] = []
    if params[:team].nil?
      @team = Team.find_by(id: params[:team_id])
      flash[:validation_errors].push "Invalid team selection" if @team.nil?

      if !@team.nil? && params[:password] == @team.password
        @user = @team.users.create(user_params)
      else
        flash[:validation_errors].push "Team password was not correct"
      end
    else 
      @team = Team.create(team_params)
      @user = @team.users.create(user_params) if !@team.nil? && @team.valid?
      @team.delete unless !@user.nil? && @user.valid?
    end 

    if !@user.nil? && @user.valid? && !@team.nil? && @team.valid?
      log_in @user
      respond_to do |format| 
        format.html { redirect_to team_path(@team) }
        format.js
      end
    else
      flash[:validation_errors].push @user.errors.full_messages if !@user.nil?
      flash[:validation_errors].push @team.errors.full_messages if !@team.nil?
      redirect_to :back
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
