class ReviewsController < ApplicationController
  def new
  end

  def create
    @card = Card.find(params[:id])
    user_input = params[:user_input]
    if @card.review(user_input)
      flash[:notice] = "Правильно!"
    else
      flash[:alert] = "Неправильно!"
    end
    redirect_to :back
  end

  private

  def review_params
    params.require(:card).permit(:review_date)
  end
end
