class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    if login(params[:session][:email], params[:session][:password])
      flash[:success] = "Login successful"
      redirect_to root_path
    else
      flash[:alert] = "Login failed"
      render "new"
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
