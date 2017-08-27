require_relative '../acceptance_helper'

feature 'Watch questions', %q{
  In order to watch questions
  As an user
  I want to be able to watch list of questions
} do
  
  given!(:questions) { create_list(:question, 5) }
  
  scenario 'Any user watches all questions' do
    visit questions_path
    
    questions.each do |question|
      expect(page).to have_content(question.title)
      expect(page).to have_content(question.body)  
    end
    expect(page).to have_content 'Ask question'
  end
  
  scenario 'Any user watch any question' do
    question = create(:question)
    question.update(title: 'Title text', body: 'Question text')
    visit question_path(question)

    expect(page).to have_content 'Answers to question'
    expect(page).to have_content 'Title text'
    expect(page).to have_content 'Question text'
  end
  
end