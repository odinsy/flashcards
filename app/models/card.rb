class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate  :texts_are_different
  before_validation :set_review_date, on: :create

  scope :to_repeat, -> { where("review_date <= ?", Date.today) }

  def compare(user_input)
    if user_input.downcase.strip == self.original_text.downcase.strip
      set_review_date
    end
  end

  private

  def texts_are_different
    if self.original_text.downcase.strip == self.translated_text.downcase.strip
      errors.add(:original_text, "Text can't be the same")
    end
  end

  def set_review_date
    self.review_date += 3.days
  end

end
