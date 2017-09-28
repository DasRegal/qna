require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body}
  it { should validate_length_of(:body).is_at_most(255) }
  it { should belong_to(:question) }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should accept_nested_attributes_for(:attachments).allow_destroy(true) }
  
  let!(:user) { create(:user) }
  let!(:answer) { create(:answer, user: user) }
  let(:another_answer) { create(:answer) }
  
  describe '#set_favorite' do
    let(:question_with_answers) { create(:question, :with_answers) }
    
    it 'sets favorite flag to true' do
      answer = question_with_answers.answers.first
      answer.set_favorite
      
      expect(answer.is_favorite?).to eq true
    end
    
    it 'resets favorite flag to false' do
      answer = question_with_answers.answers.first
      answer.set_favorite
      answer.set_favorite
      answer.reload
      
      expect(answer.is_favorite?).to eq false
    end
  end
  
  context '.vote' do 
    it 'change votes count' do 
      expect{ another_answer.vote(user, -1) }.to change(Vote, :count).by 1
    end

    it 'created vote have correct params' do
      vote = another_answer.vote(user, -1)

      expect(vote.votable).to eq another_answer
      expect(vote.user_id).to eq user.id
      expect(vote.count).to eq -1
    end
  end
  
  context '.is_vote?' do
    let!(:vote_up) { create(:vote, :up, user: user, votable: answer) }
    
    it 'return true if user has vote' do 
      expect(answer.is_vote?(user, 1)).to eq true
    end

    it 'return false if user dont has vote' do
      expect(another_answer.is_vote?(user, 1)).to eq false 
    end
  end
end
