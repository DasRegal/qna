require 'rails_helper'

feature 'Delete question', %q{
  In order to delete question
  As an authenticated user
  I want to be able to delete question
} do
  
  given(:user_with_questions) { create(:user, :with_questions) }
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  
  scenario 'Author can delete question' do
    user = user_with_questions
    sign_in(user)

    visit question_path(user.questions.first)
    click_on 'Delete'
    
    expect(page).to have_content 'Your question is deleted.'
  end
  
  scenario 'Any user can delete question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Delete'

    expect(page).to have_content 'You are not the author.'
  end
  
end