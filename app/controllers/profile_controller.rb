class ProfileController < ApplicationController

  def edit
  end

  def show
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = "Your profile has been updated!"
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:profile).permit(:email, :password, :password_confirmation)
  end

end
