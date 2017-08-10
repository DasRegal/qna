class Question < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50  }
  validates :body,  presence: true, length: { minimum: 5, maximum: 255 }
end
