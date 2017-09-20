require_relative '../acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistakes
  As an author of answer
  Id like to be able to edit my answers
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }
  
  scenario 'Any user try to edit other users answer' do
    visit question_path(question)
    
    within '.answers' do
      expect(page).to_not have_link 'Edit'
    end
  end
  
  scenario 'Author try to edit his answer', js: true do
    sign_in user
    visit question_path(question)
    fill_in 'Body', with: 'First text'
    click_on 'Create Answer'
    visit question_path(question)
    
    within '.answers' do
      click_on 'Edit'    
      fill_in 'Answer', with: 'edited answer'
      click_on 'Save'
      
      expect(page).to have_content 'edited answer'
      expect(page).to_not have_content 'First text'
      expect(page).to_not have_selector 'textarea'
    end
  end
end