require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_length_of(:title).is_at_least(5).is_at_most(50) }
  it { should validate_length_of(:body).is_at_least(5).is_at_most(255) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should accept_nested_attributes_for(:attachments).allow_destroy(true) }
  
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let(:another_question) { create(:question) }
  
  context '.vote' do 
    it 'change votes count' do 
      expect{ another_question.vote(user, 1) }.to change(Vote, :count).by 1
    end
    
    it 'created vote have correct params' do
      vote = another_question.vote(user, -1)
      expect(vote.votable_id).to eq another_question.id
      expect(vote.votable_type).to eq 'Question'
      expect(vote.user_id).to eq user.id
      expect(vote.count).to eq -1
    end
  end

  context '.vote?' do 
    let!(:vote_up) { create(:vote, :up, user: user, votable: question) }
    
    it 'return true if user has vote' do 
      expect(question.is_vote?(user, 1)).to eq true
    end

    it 'return false if user dont has vote' do
      expect(another_question.is_vote?(user, 1)).to eq false 
    end
  end
end
