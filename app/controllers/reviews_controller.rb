class ReviewsController < ApplicationController

  def new
    @card = current_user.card_for_review
  end

  def create
    @card = current_user.cards.find(review_params[:card_id])
    if @card.review(review_params[:user_input])
      flash[:notice] = "Правильно!"
    else
      flash[:alert] = "Неправильно!"
    end
    redirect_to :back
  end

  private

  def review_params
    params.require(:review).permit(:user_input, :card_id)
  end

end
