class User < ActiveRecord::Base

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  belongs_to :current_deck, class_name: "Deck"
  has_many :decks
  has_many :cards, through: :decks
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 3 }, if: :new_record?

  def card_for_review
    if self.current_deck
      cards_scope = self.current_deck.cards
    else
      cards_scope = self.cards
    end
    cards_scope.to_repeat.order("RANDOM()").first
  end

end
