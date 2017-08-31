require_relative '../acceptance_helper'

feature 'Question editing', %q{
  In order to fix misatkes
  As an author of question
  Id like to be able to edit my question
} do
  
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:my_qustion) { create(:question, user: user) }
  
  scenario 'Any user try to edit other users answer' do
    visit question_path(question)
    
    within '.question' do
      expect(page).to_not have_content 'Edit'
    end
  end
  
  scenario 'Author try to edit his question', js: true do
    sign_in user
    visit question_path(my_qustion)

    within '.question' do
      click_on 'Edit'
      fill_in 'Title', with: 'New title'
      fill_in 'Body', with: 'New question'
      click_on 'Save'
      
      expect(page).to_not have_content question.body
      expect(page).to_not have_content question.title
      expect(page).to have_content 'New title'
      expect(page).to have_content 'New question'
      expect(page).to_not have_selector 'form#edit-question'
    end
  end
  
end