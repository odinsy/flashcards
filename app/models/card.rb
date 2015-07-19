class Card < ActiveRecord::Base
  belongs_to  :user
  mount_uploader :image, ImageUploader

  validates :user, presence: true
  validates :original_text, :translated_text, :review_date, presence: true
  validate  :texts_are_different
  before_validation :set_review_date, on: :create

  scope :to_repeat, -> { where("review_date <= ?", Date.today) }

  def review(user_input)
    if prepare_word(user_input) == prepare_word(original_text)
      update_attributes(review_date: Date.today + 3.days)
    end
  end

  def prepare_word(string)
    string.mb_chars.downcase.strip
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
