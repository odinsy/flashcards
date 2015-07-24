class Deck < ActiveRecord::Base

  belongs_to  :user
  has_many  :cards, dependent: :destroy
  # accepts_nested_attributes_for :cards

  validates :title, presence: true, length: { minimum: 5 }
  after_update :check_current

  def make_current
    self.update_attributes(current: true)
    Deck.where(["user_id = ? AND id != ?", self.user_id, self.id]).update_all(current: false)
  end

  private

  def check_current
    if self.current == true
      Deck.where(["user_id = ? AND id != ?", self.user_id, self.id]).update_all(current: false)
    end
  end

end
