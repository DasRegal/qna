require 'rails_helper'

feature 'Create answer', %q{
  In order to create answer
  As an authenticated user
  I want to be able to create answer
} do
  
  given(:question) { create(:question) }
  given(:user) { create(:user) }
  
  scenario 'Authenticated user creates answer', js: true do
    sign_in(user)
    
    visit question_path(question)
    fill_in 'Body', with: 'Body text'
    click_on 'Create Answer'
    
    expect(page).to have_content 'Your answer successfully created.'
    within '.answers' do
      expect(page).to have_content 'Body text'
    end
  end
  
  scenario 'Non-authenticated user tries to answer to question', js: true do
    visit question_path(question)
    click_on 'Create Answer'
    
    expect(page).to_not have_content 'Your answer successfully created.'
  end
  
  scenario 'Authenticated user tries to creates invalid answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Create Answer'

    expect(page).to have_content 'Your answer is not create.'
  end
  
end