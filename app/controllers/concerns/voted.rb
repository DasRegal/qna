module Voted
  extend ActiveSupport::Concern
  
  included do
    before_action :set_obj, only: [:vote_up, :vote_down]
  end
  
  def vote_up
    if @obj.is_vote?(current_user, 1) || current_user.author_of?(@obj)
      render json: 'You already voted', status: 422
    else
      @obj.vote(current_user, 1)
      render json: @obj.votes.sum(:count)
    end
  end

  def vote_down
    if @obj.is_vote?(current_user, -1) || current_user.author_of?(@obj)
      render json: 'You already voted', status: 422
    else
      @obj.vote(current_user, -1)
      render json: @obj.votes.sum(:count)
    end
  end

  private
  
  def model_klass
    controller_name.classify.constantize
  end
  
  def set_obj
    @obj = model_klass.find(params[:id])
  end
end