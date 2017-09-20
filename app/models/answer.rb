class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
  
  validates :body, presence: true, length: { maximum: 255 }
  
  scope :favorite_order, -> { order(is_favorite: :desc) }
  scope :all_favorites,  -> { where(is_favorite: true)  }
  
  def set_favorite
    self.transaction do
      self.question.answers.update_all(is_favorite: false)
      self.update!(is_favorite: true)
    end
  end
end
