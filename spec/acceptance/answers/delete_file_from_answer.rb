require_relative '../acceptance_helper'

feature 'delete files from answer', %q{
  In order to delete file
  As an answer author
  Id like to be able to delete attach files
} do 

  given(:user) { create(:user) }
  given(:answer_attach) { create(:attachment) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer) }
  given(:user2) { create(:user) }

  background do 
    @user = user
    sign_in(@user)
    @question = question
    @answer = answer
    @answer.update(question: @question)
    @answer_attach = answer_attach
    @answer_attach.update(attachable_id: @answer.id, attachable_type: "Answer")
    @answer.update(user: @user)
  end

  scenario 'author can delete file', js: true do 
    visit question_path(@question)
    click_on 'delete attach'
    expect(page).to_not have_content 'spec_helper.rb'
    expect(page).to have_content 'File deleted'
  end

  scenario 'any user can not delete', js: true do 
    @answer.update(user: user2)
    visit question_path(@question)
    expect(page).to_not have_link 'delete attach'
  end
end