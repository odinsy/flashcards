class ReviewsController < ApplicationController

  def new
    @card = Card.to_repeat.order("RANDOM()").first
  end

  def create
    @card = Card.find(review_params[:card_id])
    @card.review(review_params[:user_input])
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
