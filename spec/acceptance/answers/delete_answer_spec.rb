require_relative '../acceptance_helper'

feature 'Delete answer', %q{
  In order to delete answer
  As an authenticated user
  I want to be able to delete answer
} do
  
  given(:question_with_answers) { create(:question, :with_answers)}
  given(:user) { create(:user) }
  
  scenario 'Author can delete answer', js: true do
    sign_in(user)
    question_with_answers.answers.update_all(user_id: user.id)
    question_with_answers.answers.first.update(body: "Foobar")
    
    visit question_path(question_with_answers)
    click_on 'Delete answer', match: :first
    
    expect(page).to have_content 'Your answer is deleted.'
    expect(page).to_not have_content 'Foobar'
  end
  
  scenario 'Any user can not delete answer' do
    sign_in(user)

    visit question_path(question_with_answers)
    expect(page).to_not have_content 'Delete answer'
  end
  
end