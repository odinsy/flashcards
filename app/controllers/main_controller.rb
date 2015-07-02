class MainController < ApplicationController

  def index
    @card = Card.to_repeat.sample
  end

end
