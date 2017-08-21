require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete answer
  As an authenticated user
  I want to be able to delete answer
} do
  
  given(:user) { create(:user) }
  
  scenario 'Author can delete answer' do
    sign_in(user)
    question = create(:question)
    
    
  end
  
end