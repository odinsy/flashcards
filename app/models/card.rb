class Card < ActiveRecord::Base
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate  :check_text
  before_validation :set_review_date, on: :create

  private

  def check_text
    if self.original_text.downcase.strip == self.translated_text.downcase.strip
      errors.add(:original_text, "Text can't be the same")
    end
  end

  def set_review_date
    self.review_date = (self.review_date + 3)
  end

end
