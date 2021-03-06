class User < ApplicationRecord
  has_many :answers
  has_many :questions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def author_of?(obj)
    self.id == obj.user_id
  end
end
