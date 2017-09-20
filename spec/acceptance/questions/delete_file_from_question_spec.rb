require_relative '../acceptance_helper'

feature 'delete files from question', %q{
  In order to delete file
  As an question author
  Id like to be able to delete attach files
} do 

  given(:user) { create(:user) }
  given(:question_attach) { create(:attachment) }
  given(:question) { create(:question) }
  given(:user2) { create(:user) }

  background do 
    @user = user
    sign_in(@user)
    @question = question
    @question_attach = question_attach
    @question_attach.update(attachable_id: @question.id, attachable_type: "Question")
    @question.update(user: @user)
  end

  scenario 'author can delete file', js: true do 
    visit question_path(@question)
    click_on 'delete attach'
    expect(page).to_not have_content 'spec_helper.rb'
    
    expect(page).to have_content 'File deleted'
  end

  scenario 'any user can not delete', js: true do 
    @question.update(user: user2)
    visit question_path(@question)
    
    expect(page).to_not have_link 'delete attach'
  end
end