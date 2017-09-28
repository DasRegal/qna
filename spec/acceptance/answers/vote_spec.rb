require_relative '../acceptance_helper'

feature 'voting answers', %q{
  As authenticated user 
  I want to able vote to answers
} do 
  given!(:user) { create(:user) }
  given!(:question) { create(:question) } 
  given!(:answer) { create(:answer, question: question) }


  scenario 'any user try to vote ' do 
    visit question_path(question)

    within '.answers' do 
      expect(page).to_not have_content 'vote_up'
      expect(page).to_not have_content 'vote_down'
    end
  end

  scenario 'user try to vote for not his answer', js: true do 
    sign_in user
    answer.update(user: user)
    visit question_path(question)
    
    within '.answers' do 
      expect(page).to_not have_link 'vote_up'
      expect(page).to_not have_link 'vote_down'
    end
  end

  describe 'user can revote' do 
    before { sign_in user }

    scenario 'from up to down', js: true do 
      create(:vote, :up, user: user, votable: answer) 
      visit question_path(question)
      within '.answers' do 
        votes = find(".total_votes").text.to_i  
        click_on 'vote_down'
        sleep(2)
        
        expect(find('.total_votes').text.to_i).to eq votes-2
      end
    end

    scenario 'from down to up', js: true do 
      create(:vote, :down, user: user, votable: answer) 
      visit question_path(question)
      within '.answers' do 
        votes = find(".total_votes").text.to_i  
        click_on 'vote_up'
        sleep(2)
        
        expect(find('.total_votes').text.to_i).to eq votes+2
      end
    end
  end

  describe 'user already voted' do 
    before { sign_in user }

    scenario 'voted up', js: true do 
      create(:vote, :up, user: user, votable: answer)       
      visit question_path(question)
      within '.answers' do 
        votes = find(".total_votes").text.to_i  
        click_on 'vote_up'
        sleep(2)
        
        expect(find('.total_votes').text.to_i).to eq votes
      end
      expect(page).to have_content 'You already voted'
    end

    scenario 'voted down', js: true do 
      create(:vote, :down, user: user, votable: answer)       
      visit question_path(question)
      within '.answers' do 
        votes = find(".total_votes").text.to_i  
        click_on 'vote_down'
        sleep(2)
        
        expect(find('.total_votes').text.to_i).to eq votes
      end
      expect(page).to have_content 'You already voted'
    end
  end
end