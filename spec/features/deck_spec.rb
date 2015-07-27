require "rails_helper"

describe "decks" do

  let!(:user) { create(:user) }

  context "when user trying to view or edit a deck of another user" do

    before :each do
      @user2 = create(:user, email: "user2@example.com")
      @deck = create(:deck, user_id: @user2.id)
      login("user@example.com", "password")
    end

    it "restricts access to edit a deck" do
      visit edit_deck_path(@deck)
      expect(page).to have_content "Invalid deck!"
    end

    it "restricts access to view a deck" do
      visit deck_path(@deck)
      expect(page).to have_content "Invalid deck!"
    end

  end

  context "when user trying to view or edit his card" do

    before :each do
      @deck = create(:deck, user_id: user.id)
      login("user@example.com", "password")
    end

    it "shows the deck's page" do
      visit deck_path(@deck)
      expect(page).to have_content("Колода 1")
    end

    it "shows the page of edit card" do
      visit edit_deck_path(@deck)
      expect(page).to have_button "Update Deck"
    end

  end

  context "when user trying to view decks" do

    it "shows his decks" do
      @deck = create(:deck, user_id: user.id)
      login("user@example.com", "password")
      visit decks_path
      expect(page).to have_content "Колода 1"
    end

    it "doesn't show decks of another user" do
      @user2 = create(:user, email: "user2@example.com")
      @deck = create(:deck, user_id: @user2.id)
      login("user@example.com", "password")
      visit decks_path
      expect(page).to_not have_content "Колода 1"
    end

  end

end
