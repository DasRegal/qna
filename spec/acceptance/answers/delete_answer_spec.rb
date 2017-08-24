require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete answer
  As an authenticated user
  I want to be able to delete answer
} do
  
  given(:question_with_answers) { create(:question, :with_answers)}
  given(:user) { create(:user) }
  
  scenario 'Author can delete answer' do
    sign_in(user)
    question_with_answers.answers.update_all(user_id: user.id)
    
    visit question_path(question_with_answers)
    click_on 'Delete answer', match: :first
    
    expect(page).to have_content 'Your answer is deleted.'
  end
  
  scenario 'Any user can delete question' do
    sign_in(user)

    visit question_path(question_with_answers)
    expect(page).to_not have_content 'Delete answer'
  end
  
end