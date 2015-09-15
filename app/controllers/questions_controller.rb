class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end 

  def show
    @question = Question.find(params[:id])
  end

  def submit 
    @question = Question.find(params[:id])
    if @question.answer == params[:answer]
      flash[:success] = "Question answered successfuly!"
    else
      flash[:failure] = "Wrong answer"
    end
    redirect_to :back
  end
end 
