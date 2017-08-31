class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  
  validates :body, presence: true, length: { maximum: 255 }
  
  scope :favorit_order, -> { order(is_favorite: :desc) }
  
  def set_favorite
    self.transaction do
      self.question.answers.update_all(is_favorite: false)
      self.update(is_favorite: true)
    end
  end
end
