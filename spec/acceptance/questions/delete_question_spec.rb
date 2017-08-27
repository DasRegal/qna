require_relative '../acceptance_helper'

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
    user.questions.first.update(body: "Foobar")

    visit question_path(user.questions.first)
    click_on 'Delete'
    
    expect(page).to have_content 'Your question is deleted.'
    expect(page).to_not have_content 'Foobar'
  end
  
  scenario 'Any user can not delete question' do
    sign_in(user)

    visit question_path(question)
    
    expect(page).to_not have_content 'Delete'
  end
  
end