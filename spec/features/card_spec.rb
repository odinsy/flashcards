require "rails_helper"

describe "review" do

  before :each do
    @user = create(:user)
    @card = create(:card, user_id: @user.id)
    @card.update_attributes(review_date: Date.today)
    login("user@example.com", "password")
    visit new_review_path
  end

  it "shows translated text" do
    expect(page).to have_content @card.translated_text
  end

  it "shows 'Правильно!' when answer is correct" do
    fill_in "review_user_input", with: " TexT МиР "
    click_on "Review"
    expect(page).to have_content "Правильно!"
  end

  it "shows 'Неправильно!' when answer is incorrect" do
    fill_in "review_user_input", with: "123"
    click_on "Review"
    expect(page).to have_content "Неправильно!"
  end

end

describe "cards" do

  before :each do
    @user = create(:user)
  end

  context "restricts access to view or edit a card of another user" do

    before :each do
      @user2 = create(:user, email: "user2@example.com")
      @card = create(:card, user_id: @user2.id)
      @card.update_attributes(review_date: Date.today)
      login("user@example.com", "password")
    end

    it "restricts access when user trying to view a card" do
      visit card_path(@card)
      expect(page).to have_content "Access denied!"
    end

    it "restricts access when user trying to edit a card" do
      visit edit_card_path(@card)
      expect(page).to have_content "Access denied!"
    end

  end

  context "allows to view or edit user card" do

    before :each do
      @card = create(:card, user_id: @user.id)
      @card.update_attributes(review_date: Date.today)
      login("user@example.com", "password")
    end

    it "shows the card's page of the user" do
      visit card_path(@card)
      expect(page).to have_content @card.translated_text
    end

    it "shows the page for edit a user card" do
      visit edit_card_path(@card)
      expect(page).to have_content @card.translated_text
    end

  end

  context "view user cards" do

    it "doesn't show cards of another user" do
      @user2 = create(:user, email: "user2@example.com")
      @card = create(:card, user_id: @user2.id)
      @card.update_attributes(review_date: Date.today)
      login("user@example.com", "password")
      visit cards_path
      expect(page).to_not have_content @card.translated_text
    end

    it "shows cards of the user" do
      @card = create(:card, user_id: @user.id)
      @card.update_attributes(review_date: Date.today)
      login("user@example.com", "password")
      visit cards_path
      expect(page).to have_content @card.translated_text
    end

  end

end
