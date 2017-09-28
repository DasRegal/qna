require_relative '../acceptance_helper'

feature 'voting question', %q{
  As authenticated user 
  I want to able vote to question
} do 
  given!(:user) { create(:user) }
  given!(:question) { create(:question) } 


  scenario 'any user try to vote ' do 
    visit question_path(question)

    expect(page).to_not have_content 'vote_up'
    expect(page).to_not have_content 'vote_down'
  end

  scenario 'user try to vote for not his answer', js: true do 
    sign_in user
    visit question_path(question)
    
    votes = find('.total_votes').text.to_i  
    click_on 'vote_up'
    sleep(2)
    
    expect(find('.total_votes').text.to_i).to eq votes+1
  end

  describe 'user can revote' do 
    before { sign_in user }

    scenario 'from up to down', js: true do 
      create(:vote, :up, user: user, votable: question) 
      visit question_path(question)
      votes = find(".total_votes").text.to_i  
      click_on 'vote_down'
      sleep(2)
      
      expect(find('.total_votes').text.to_i).to eq votes-2
    end

    scenario 'from down to up', js: true do 
      create(:vote, :down, user: user, votable: question) 
      visit question_path(question)
      votes = find(".total_votes").text.to_i  
      click_on 'vote_up'
      sleep(2)
      
      expect(find('.total_votes').text.to_i).to eq votes+2
    end
  end

  describe 'user already voted' do 
    before { sign_in user }

    scenario 'voted up', js: true do 
      create(:vote, :up, user: user, votable: question) 
      visit question_path(question)
      votes = find(".total_votes").text.to_i  
      click_on 'vote_up'
      sleep(2)

      expect(find('.total_votes').text.to_i).to eq votes
      expect(page).to have_content 'You already voted'
    end

    scenario 'voted down', js: true do 
      create(:vote, :down, user: user, votable: question)       
      visit question_path(question)
      votes = find(".total_votes").text.to_i  
      click_on 'vote_down'
      sleep(2)
      
      expect(find('.total_votes').text.to_i).to eq votes
      expect(page).to have_content 'You already voted'
    end
  end
end