class CardsController < ApplicationController

  before_action :find_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = current_user.cards
  end

  def new
    @deck = current_user.decks.build
    @card = @deck.cards.build
  end

  def show
  end

  def edit
  end

  def create
    @card = Card.create(card_params)
    @card.deck.update_attributes(user_id: current_user.id) unless @card.deck.nil?
    if @card.errors.empty?
      redirect_to cards_path
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
    params.require(:card).permit(:original_text, :translated_text, :review_date, :image, :deck_id, :user_id, :new_deck)
  end

  def find_card
    @card = current_user.cards.find(params[:id])
  end

  def invalid_card
    redirect_to cards_path, notice: "Invalid card!"
  end

end
