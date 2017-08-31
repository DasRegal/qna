require_relative '../acceptance_helper'

feature 'Favorite answer', %q{
  In order to choose favorite answer
  As an authenticated user
  I want to be able to choose favorite answer
} do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answers) { create_list(:answer, 5, question: question, user: user) }
  given(:not_his_answers) { create_list(:answer, 5, question: question) }
  
  scenario 'Author try to choose favorite answer', js: true do
    sign_in(user)
    answers
    visit question_path(question)
    click_on 'Favorite', match: :first
    
    expect(page).to have_css '.favorite'
  end
  
  scenario 'Any user try to choose favorite answer' do
    sign_in(user)
    not_his_answers
    visit question_path(question)
    
    expect(page).to_not have_link 'Favorite'
  end
  
end