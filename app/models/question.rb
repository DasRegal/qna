class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 5, maximum: 50  }
  validates :body,  presence: true, length: { minimum: 5, maximum: 255 }
end
