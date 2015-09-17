class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end 

  def show
    @question = Question.find(params[:id])
    if !logged_in
      flash.now[:warning] = "You cannot answer a question unless you are logged in!"
    elsif !Answered.find_by(questionID: @question.id, teamID: current_user.team_id).nil?
      flash.now[:warning] = "Your team has already answered this question!"
    end 
  end

  def submit 
    @question = Question.find(params[:id])
    if @question.answer == params[:answer]
      flash[:success] = "Question answered successfuly!"
      Answered.create(teamID: current_user.team_id, questionID: @question.id)
      redirect_to questions_path
    else
      flash[:failure] = "Wrong answer"
      redirect_to :back
    end
  end
end 
