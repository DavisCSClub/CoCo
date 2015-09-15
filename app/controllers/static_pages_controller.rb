class StaticPagesController < ApplicationController
  def Home
  end

  def Scoreboard
    @questions = Question.all
    @teams     = Team.all
    @answered  = Answered.all
    @leader    = current_leader 
  end

  private 

    # Return the Team that is leading, or nil if none is leading
    def current_leader 
      @teams = Team.order(questions_answered: :desc)
      @first  = @teams.first
      @second = @teams.second

      if @first && (@second.nil? || @first.questions_answered > @second.questions_answered)
        @first
      else
        nil
      end
    end

end
