require "rails_helper"

describe "the review process" do
  before :each do
    @card = create(:card)
    @card.review_date = Date.today
    @card.save
    visit new_review_path
  end

  it "shows translated text" do
    expect(page).to have_content @card.translated_text
  end

  it "shows 'Правильно!' when answer is correct" do
    fill_in "review_user_input", with: " TeXt 1123 МиРуМ   "
    click_on 'Review'
    expect(page).to have_content "Правильно!"
  end

  it "shows 'Неравильно!' when answer is incorrect" do
    fill_in "review_user_input", with: "123123123"
    click_on 'Review'
    expect(page).to have_content "Неправильно!"
  end
end
