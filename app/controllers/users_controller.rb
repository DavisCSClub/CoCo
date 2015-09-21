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
    # Just so we never have to worry about it being nil
    flash[:errors] = []
    if params[:team].nil?
      @team = Team.find_by(params[:team_id])
      flash[:errors].push "Invalid team selection" if @team.nil?
    else 
      @team = Team.create(team_params)
    end 

    if !@team.nil? && params[:password] == @team.password
      @user = @team.users.create(user_params)
    else
      flash[:errors].push "Team password was not correct"
    end

    if !@user.nil? && @user.valid? && !@team.nil? && @team.valid?
      log_in @user
      respond_to do |format| 
        format.html { redirect_to team_path(@team) }
        format.js
      end
    else
      flash[:errors].push @user.errors.full_messages if !@user.nil?
      flash[:errors].push @team.errors.full_messages if !@team.nil?
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
