require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body}
  it { should validate_length_of(:body).is_at_most(255) }
  it { should belong_to(:question) }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should accept_nested_attributes_for(:attachments).allow_destroy(true) }
  
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
end
