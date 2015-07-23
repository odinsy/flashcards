class Deck < ActiveRecord::Base

  belongs_to  :user
  has_many    :cards, dependent: :destroy
  accepts_nested_attributes_for :cards

  validates :title, presence: true

  def make_current
    self.update_attributes(current: true)
    Deck.where("id != ?", self.id).update_all(current: "false")
  end

end
