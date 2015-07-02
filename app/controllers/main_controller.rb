class MainController < ApplicationController
  def index
    @card = Card.to_repeat.order("RANDOM()").first
  end
end
