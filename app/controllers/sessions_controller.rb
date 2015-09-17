class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email], name: params[:session][:name])
    if user.nil?
      flash[:failure] = "Invalid User/Email combination"
      redirect_to :back
    else
      log_in user
      redirect_to user.team
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
