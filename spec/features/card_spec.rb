require "rails_helper"

describe "cards" do

  before :each do
    @user = create(:user)
  end

  context "when user trying to view or edit a card of another user" do

    before :each do
      @user2 = create(:user, email: "user2@example.com")
      @deck = create(:deck, user_id: @user2.id)
      @card = create(:card, deck_id: @deck.id)
      @card.update_attributes(review_date: Date.today)
      login("user@example.com", "password")
    end

    it "restricts access to view a card" do
      visit card_path(@card)
      expect(page).to have_content "Invalid card!"
    end

    it "restricts access to edit a card" do
      visit edit_card_path(@card)
      expect(page).to have_content "Invalid card!"
    end

  end

  context "when user trying to view or edit his card" do

    before :each do
      @deck = create(:deck, user_id: @user.id)
      @card = create(:card, deck_id: @deck.id)
      @card.update_attributes(review_date: Date.today)
      login("user@example.com", "password")
    end

    it "shows the card's page" do
      visit card_path(@card)
      expect(page).to have_content @card.translated_text
    end

    it "shows the page for edit a user card" do
      visit edit_card_path(@card)
      expect(page).to have_content @card.translated_text
    end

  end

  context "when user trying to view cards" do

    it "doesn't show cards of another user" do
      @user2 = create(:user, email: "user2@example.com")
      @deck = create(:deck, user_id: @user2.id)
      @card = create(:card, deck_id: @deck.id)
      @card.update_attributes(review_date: Date.today)
      login("user@example.com", "password")
      visit cards_path
      expect(page).to_not have_content @card.translated_text
    end

    it "shows cards of the user" do
      @deck = create(:deck, user_id: @user.id)
      @card = create(:card, deck_id: @deck.id)
      @card.update_attributes(review_date: Date.today)
      login("user@example.com", "password")
      visit cards_path
      expect(page).to have_content @card.translated_text
    end

  end

end
