require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questio
} do
  
  given(:user) { create(:user) }
  
  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Text question'
    fill_in 'Body', with: 'Body question'
    click_on 'Create'
    
    expect(page).to have_content 'Your question successfully created.'
    
    expect(page).to have_content 'Text question'
    expect(page).to have_content 'Body question'
  end
  
  scenario 'Authenticated user creates question vith invalid params' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'

    click_on 'Create'
    
    expect(page).to have_content 'Title can\'t be blank'
    expect(page).to have_content 'Title is too short'
    expect(page).to have_content 'Body can\'t be blank'
    expect(page).to have_content 'Body is too short'
  end
  
  scenario 'Non-authenticated user tries to create question' do
    visit questions_path
    click_on 'Ask question'
    
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
  
end