class StaticPagesController < ApplicationController
  def Home
  end

  def Scoreboard
    @questions = Question.all
    @teams = Team.all
    @answered = Answered.all
  end
end
