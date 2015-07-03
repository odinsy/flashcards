class CardsController < ApplicationController

  before_action :find_card, only: [:show, :edit, :update, :destroy, :review]

  def index
    @cards = Card.all.order(:id)
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.create(card_params)
    if @card.errors.empty?
      redirect_to @card
    else
      render "new"
    end
  end

  def update
    @card.update_attributes(card_params)
    if @card.errors.empty?
      redirect_to @card
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

    def card_params
      params.require(:card).permit(:original_text, :translated_text, :review_date)
    end

    def find_card
      @card = Card.find(params[:id])
    end

end
