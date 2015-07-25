class Card < ActiveRecord::Base

  belongs_to :deck
  mount_uploader :image, ImageUploader

  validates :original_text, :translated_text, :review_date, :deck_id, presence: true
  validate  :texts_are_different
  before_validation :set_review_date, on: :create

  scope :to_repeat, -> { where("review_date <= ?", Date.today) }

  def self.create_with_deck(params)
    if params[:deck_id].blank?
      deck = Deck.create(title: params[:deck][:title], user_id: params[:deck][:user_id])
      create(params.deep_merge!(deck_id: deck[:id]).except!(:deck))
    elsif params[:deck_id]
      create(params.except!(:deck))
    end
  end

  def review(user_input)
    if prepare_word(user_input) == prepare_word(original_text)
      update_attributes(review_date: Date.today + 3.days)
    end
  end

  def prepare_word(string)
    string.mb_chars.downcase.strip
  end

  def self.random_card_to_review
    to_repeat.order("RANDOM()").first
  end

  private

  def texts_are_different
    if prepare_word(original_text) == prepare_word(translated_text)
      errors.add(:original_text, "Text can't be the same")
    end
  end

  def set_review_date
    self.review_date = Date.today + 3.days
  end

end
