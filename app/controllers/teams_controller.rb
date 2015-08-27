class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def show
    @teams = Team.all
  end

  def create
    @team = Team.new team_params
    @team.save
    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name, :password)
  end
end
