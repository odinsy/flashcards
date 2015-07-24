class DecksController < ApplicationController

  before_action :find_deck, only: [:show, :edit, :update, :destroy, :make_current]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_deck

  def make_current
    @deck.make_current
    redirect_to decks_path
  end

  def index
    @decks = current_user.decks
  end

  def new
    @deck = current_user.decks.build
  end

  def show
  end

  def edit
  end

  def create
    @deck = current_user.decks.create(deck_params)
    if @deck.errors.empty?
      redirect_to decks_path
    else
      render "new"
    end
  end

  def update
    @deck.update_attributes(deck_params)
    if @deck.errors.empty?
      redirect_to decks_path
    else
      render "edit"
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path
  end

  private

  def deck_params
    params.require(:deck).permit(:title, :current)
  end

  def find_deck
    @deck = current_user.decks.find(params[:id])
  end

  def invalid_deck
    redirect_to decks_path, notice: "Invalid deck!"
  end

end
