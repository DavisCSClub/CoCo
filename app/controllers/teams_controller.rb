class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def index 
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @questions = Question.all
    @answered = Answered.all
  end

  def create
    @team = Team.new team_params
    if @team.save
      redirect_to teams_path 
    else
      redirect_to new_team_path, alert: "Team could not be created"
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :password)
  end
end
