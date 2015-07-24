class Deck < ActiveRecord::Base

  belongs_to :user
  has_many :cards, dependent: :destroy
  # accepts_nested_attributes_for :cards

  validates :title, presence: true, length: { minimum: 5 }

  def check_current
    user.current_deck == self
  end

end
