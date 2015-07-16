class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :restrict_access, only: [:show, :edit]

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.create(user_params)
    if @user.errors.empty?
      login(params[:user][:email], params[:user][:password])
      flash[:success] = 'Welcome!'
      redirect_back_or_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)
    if @user.errors.empty?
      flash[:success] = 'Password updated!'
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def find_user
    @user = current_user
  end

  def restrict_access
    unless current_user == User.find(params[:id])
      flash[:warning] = 'Access denied!'
      redirect_to (request.referrer || root_path)
    end
  end

end
