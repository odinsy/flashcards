require "rails_helper"

describe "review" do

  let!(:user) { create(:user) }

  before :each do
    @deck = create(:deck, user_id: user.id)
    @card = create(:card, deck_id: @deck.id)
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
