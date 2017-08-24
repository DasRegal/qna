require 'rails_helper'

feature 'Watch questions', %q{
  In order to watch questions
  As an user
  I want to be able to watch list of questions
} do
  
  scenario 'Any user watches all questions' do
    visit questions_path
    
    expect(page).to have_content 'Ask question'
  end
  
  scenario 'Any user watch any question' do
    question = create(:question)
    visit question_path(question)

    expect(page).to have_content 'Answers to question'
  end
  
end