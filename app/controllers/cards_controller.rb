class CardsController < ApplicationController

  before_action :find_card, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_card

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
    @card = Card.create_with_deck(card_params)
    if @card.errors.empty?
      redirect_to deck_path(@card.deck)
    else
      render "new"
    end
  end

  def update
    @card.update_attributes(card_params.except(:deck))
    if @card.errors.empty?
      redirect_to @card
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to deck_path(@card.deck)
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :image, :deck_id, deck: [:title]).deep_merge(deck: {user_id: current_user.id})
  end

  def find_card
    @card = current_user.cards.find(params[:id])
  end

  def invalid_card
    redirect_to cards_path, notice: "Invalid card!"
  end

end
