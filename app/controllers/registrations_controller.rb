class RegistrationsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.errors.empty?
      login(params[:registration][:email], params[:registration][:password])
      flash[:success] = 'Welcome!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:registration).permit(:email, :password, :password_confirmation)
    end

end
