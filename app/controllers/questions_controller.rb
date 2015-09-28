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
    if !logged_in
      redirect_to :back
    else
      @question = Question.find(params[:id])
      if @question.answer == params[:answer]
        flash[:success] = "Question answered successfuly!"
        Answered.create(teamID: current_user.team_id, questionID: @question.id)

        # TODO(aaparella) : Check if there is an easier way to do this?
        @t = Team.find(current_user.team_id)
        @t.questions_answered += 1
        @t.save

        redirect_to questions_path
      else
        flash[:failure] = "Wrong answer"
        redirect_to :back
      end
    end
  end
end 
