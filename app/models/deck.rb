class Deck < ActiveRecord::Base

  belongs_to :user
  has_many :cards, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true

  def current
    self == user.current_deck
  end

end
