require 'rails_helper'

feature 'Create answer', %q{
  In order to create answer
  As an authenticated user
  I want to be able to create answer
} do
  
  given(:question) { create(:question) }
  given(:user) { create(:user) }
  
  scenario 'Authenticated user creates answer' do
    sign_in(user)
    
    visit question_path(question)
    fill_in 'Title', with: 'Text answer'
    fill_in 'Body', with: 'Body text'
    click_on 'Create Answer'
    
    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content 'Body text'
  end
  
  scenario 'Non-authenticated user tries to answer to question' do
    visit question_path(question)
    click_on 'Create Answer'
    
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
  
  scenario 'Authenticated user tries to creates invalid answer' do
    sign_in(user)
    visit question_path(question)
    click_on 'Create Answer'

    expect(page).to have_content 'Your answer is not create.'
    expect(page).to have_content 'Body can\'t be blank'
  end
  
end