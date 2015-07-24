require "rails_helper"

describe Deck do

  let!(:user) { create(:user) }

  context "when set current deck " do

    let!(:deck) { create(:deck, user_id: user.id) }

    it "changes the value of key 'current' to 'true' in the deck" do
      deck.make_current
      expect(deck.current).to eq(true)
    end

    it "changes the value of key 'current' to 'false' in other decks" do
      deck2 = create(:deck, title: "Колода 2", current: true, user_id: user.id)
      deck.make_current
      expect(deck2.current).to eq(false)
    end

  end

end
