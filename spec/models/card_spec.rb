require "rails_helper"

RSpec.describe Card, :type => :model do

  describe "#prepare_word" do
    it "changes the text to downcase and delete spaces before and after" do
      card = create(:card)
      expect(card.prepare_word(card.original_text)).to eq("text 1123 мирум")
    end
  end

  describe "#texts_are_different" do
    it "checks that texts are different" do
      card = build(:card)
      card.valid?
      expect(card.errors[:original_text]).to_not include("Text can't be the same")
    end
    it "checks that texts are not different" do
      card = build(:card, original_text: " aSd ФыВ  ")
      card.valid?
      expect(card.errors[:original_text]).to include("Text can't be the same")
    end
  end

  describe "#set_review_date" do
    it "checks that to review_date added 3 days" do
      card = create(:card)
      expect(card.review_date).to eq(Date.today + 3.days)
    end
  end

  describe "#review" do
    it "check that if user_input == original_text to review_date added 3 days" do
      card = create(:card)
      card.review_date = Date.today
      user_input = card.original_text
      card.review(user_input)
      expect(card.review_date).to eq(Date.today + 3.days)
    end
    it "check that if user_input != original_text review_date was not cnanged" do
      card = create(:card)
      card.review_date = Date.today
      user_input = "abrakAdabra"
      card.review(user_input)
      expect(card.review_date).to eq(Date.today)
    end
  end

end
