class CardsController < ApplicationController

  before_action :find_card, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:index, :new, :create]
  before_action :restrict_access, only: [:show, :edit]

  def index
    @cards = @user.cards
  end

  def show
  end

  def new
    @card = @user.cards.build
  end

  def edit
  end

  def create
    @card = @user.cards.create(card_params)
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

    def find_user
      @user = current_user
    end

    def restrict_access
      unless current_user == @card.user
        flash[:warning] = 'Access denied!'
        redirect_to (request.referrer || root_path)
      end
    end

end
