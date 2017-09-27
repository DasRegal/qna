module Votable
  extend ActiveSupport::Concern
  
  included do
    has_many :votes, as: :votable, dependent: :destroy
  end
  
  def is_vote?(user, inc)
    self.votes.where(user: user, count: inc).count > 0 
  end

  def vote(user, inc)
    self.transaction do 
      self.votes.where(user: user).destroy_all
      self.votes.create!(user: user, count: inc)
    end
  end
  
end