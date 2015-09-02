class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
  end

  def submit 
    @question = Question.find(params[:id])
    if @question.answer == params[:answer]
      puts "They got it right!"
    else
      puts "They got it wrong!"
    end
    redirect_to root_path
  end
end 
