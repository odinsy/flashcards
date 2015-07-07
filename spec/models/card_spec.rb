require "rails_helper"

describe Card do

  context "when called #prepare_word" do
    it "changes the text to downcase and delete spaces before and after" do
      card = create(:card)
      expect(card.prepare_word(card.original_text)).to eq("text 1123 мирум")
    end
  end

  context "when called method #texts_are_different" do
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

  context "when created a new card" do
    it "checks that to review_date added 3 days" do
      card = create(:card)
      expect(card.review_date).to eq(Date.today + 3.days)
    end
  end

  context "when called #review" do
    let(:card) { create(:card) }

    it "review date increases if translation is correct" do
      card.review_date = Date.today
      card.review(card.original_text)
      expect(card.review_date).to eq(Date.today + 3.days)
    end
    it "review date remains the same if translation is incorrect" do
      card.review_date = Date.today
      card.review("abrakAdabra")
      expect(card.review_date).to eq(Date.today)
    end
  end

end
