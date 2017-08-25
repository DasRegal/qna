require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:answers) }
  it { should have_many(:questions) }
  
  context 'check author_of?' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }

    it 'user is author' do 
      user
      question.update(user_id: user.id)
      expect(user).to be_author_of(question)
    end

    it 'user is not athor' do 
      expect(user).to_not be_author_of(question)
    end
  end
end