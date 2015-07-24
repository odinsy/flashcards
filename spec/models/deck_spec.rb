require "rails_helper"

describe Deck do

  let!(:user) { create(:user) }

  context "when called method #check_current" do

    let!(:deck) { create(:deck, user_id: user.id) }

    it "returns 'true' when the deck is current" do
      user.update_attributes(current_deck_id: deck.id)
      expect(deck.check_current).to eq(true)
    end

    it "returns 'false' when the deck is not current" do
      expect(deck.check_current).to eq(false)
    end

  end

  context "if selected the current deck" do

    let!(:deck) { create(:deck, user_id: user.id) }

    it "changes" do
      user.update_attributes(current_deck_id: deck.id)
      expect(user.current_deck_id).to eq(deck.id)
    end
    
  end

end
