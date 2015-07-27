require "rails_helper"

describe Card do

  before :each do
    @user = create(:user)
    @deck = create(:deck, user_id: @user.id)
  end

  context "when called #prepare_word" do
    it "changes the text to downcase and delete spaces before and after" do
      card = create(:card, deck_id: @deck.id)
      expect(card.prepare_word(card.original_text)).to eq("text мир")
    end
  end

  context "when called method #texts_are_different" do
    it "checks that texts are different" do
      card = build(:card, deck_id: @deck.id)
      card.valid?
      expect(card.errors[:original_text]).to_not include("Text can't be the same")
    end
    it "checks that texts are not different" do
      card = build(:card, original_text: " ТексТ WorlD ", deck_id: @deck.id)
      card.valid?
      expect(card.errors[:original_text]).to include("Text can't be the same")
    end
  end

  context "when created a new card" do
    it "checks that to review_date added 3 days" do
      card = create(:card, deck_id: @deck.id)
      expect(card.review_date).to eq(Date.today + 3.days)
    end
  end

  context "when called #review" do
    let!(:card) { create(:card, deck_id: @deck.id) }

    before :each do
      card.review_date = Date.today
    end

    it "review date increases if translation is correct" do
      card.review(card.original_text)
      expect(card.review_date).to eq(Date.today + 3.days)
    end
    it "review date remains the same if translation is incorrect" do
      card.review("abrakAdabra")
      expect(card.review_date).to eq(Date.today)
    end
  end

  context "when created a new card with Good parameters cards via method 'self.create_with_deck'" do

    it "returns that the card is valid, if the deck is selected and title for new deck is not written" do
      params = {original_text: "Карта 1", translated_text: "Card 1", deck_id: @deck.id, deck: {title: "", user_id: @user.id}, review_date: Date.today}
      card = Card.create_with_deck(params)
      expect(card.valid?).to eq(true)
    end

    it "returns that the card is valid, if the deck is not selected and title for new deck is written" do
      params = {original_text: "Карта 1", translated_text: "Card 1", deck_id: "", deck: {title: "Колода 2", user_id: @user.id}, review_date: Date.today}
      card = Card.create_with_deck(params)
      expect(card.valid?).to eq(true)
    end

    it "returns that the card is not valid, if the deck is not selected and title for new deck is not written" do
      params = {original_text: "Карта 1", translated_text: "Card 1", deck_id: "", deck: {title: "", user_id: @user.id}, review_date: Date.today}
      card = Card.create_with_deck(params)
      expect(card.valid?).to eq(false)
    end

  end

  context "when created a new card with Bad parameters cards via method 'self.create_with_deck'" do

    it "returns that the card is not valid, if the deck is selected and title for new deck is not written" do
      params = {original_text: "", translated_text: "", deck_id: @deck.id, deck: {title: "", user_id: @user.id}, review_date: Date.today}
      card = Card.create_with_deck(params)
      expect(card.valid?).to eq(false)
    end

    it "returns that the card is not valid, if the deck is not selected and title for new deck is written" do
      params = {original_text: "", translated_text: "", deck_id: "", deck: {title: "Колода 2", user_id: @user.id}, review_date: Date.today}
      card = Card.create_with_deck(params)
      expect(card.valid?).to eq(false)
    end

    it "returns that the card is not valid, if the deck is not selected and title for new deck is not written" do
      params = {original_text: "", translated_text: "", deck_id: "", deck: {title: "", user_id: @user.id}, review_date: Date.today}
      card = Card.create_with_deck(params)
      expect(card.valid?).to eq(false)
    end

  end

  context "when created a new deck via method 'self.create_with_deck'" do

    it "returns the deck if the title for new deck has length equal or more 5" do
      params = {original_text: "Карта 1", translated_text: "Card 1", deck_id: "", deck: {title: "Колода 2", user_id: @user.id}, review_date: Date.today}
      card = Card.create_with_deck(params)
      expect(card.deck.valid?).to eq(true)
    end

    it "returns 'nil' if the title for new deck has length less than 5" do
      params = {original_text: "Карта 1", translated_text: "Card 1", deck_id: "", deck: {title: "Коло", user_id: @user.id}, review_date: Date.today}
      card = Card.create_with_deck(params)
      expect(card.deck).to be_nil
    end

  end

end
