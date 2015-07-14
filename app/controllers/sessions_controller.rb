class SessionsController < ApplicationController
  
  skip_before_action :require_login, only: [:new, :create]

  def new
  end
  def create
    if login(params[:session][:email], params[:session][:password])
      flash.now[:success] = "Login successful"
      redirect_back_or_to root_path
    else
      flash.now[:alert] = "Login failed"
      render "new"
    end
  end
  def destroy
    logout
    redirect_to root_path
  end

end
