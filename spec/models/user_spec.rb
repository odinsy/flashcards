require "rails_helper"

describe User do

  let!(:user) { create(:user) }

  context "when called method #card_for_review" do

    before :each do
      @deck = create(:deck, user_id: user.id)
      @card = create(:card, deck_id: @deck.id)
      @card.update_attributes(review_date: Date.today)
    end

    it "returns the card for review from current deck if current deck exists" do
      user.update_attributes(current_deck_id: @deck.id)
      expect(user.card_for_review).to eq(@card)
    end

    it "returns the card for review if current deck doesn't exists" do
      expect(user.card_for_review).to eq(@card)
    end

    it "doesn't return the card of another user from current deck if current deck exists" do
      @user2 = create(:user, email: "user2@example.com")
      @deck.update_attributes(user_id: @user2.id)
      @user2.update_attributes(current_deck_id: @deck.id)
      expect(user.card_for_review).to_not eq(@card)
    end

    it "doesn't return the card of another user if current deck doesn't exists" do
      @user2 = create(:user, email: "user2@example.com")
      @deck.update_attributes(user_id: @user2.id)
      expect(user.card_for_review).to_not eq(@card)
    end

  end

end
