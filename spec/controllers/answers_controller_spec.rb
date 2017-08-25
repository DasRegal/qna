require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question_with_answers) { create(:question, :with_answers) }
  let(:question) { create(:question) }
  
  describe 'POST #create' do
    sign_in_user
    
    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(question.answers, :count).by(1)
      end
      
      it 'redirects to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
    
    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question } }.to_not change(Answer, :count)
      end
      
      it 're-render new view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question }
        expect(response).to render_template 'questions/show'
      end
    end
  end
  
  describe 'DELETE #destroy' do
    context 'users answer' do
      sign_in_user
      before { question_with_answers.answers.first.update(user_id: @user.id) }
      
      it 'deletes answer' do 
        expect { delete :destroy, params: { question_id: question_with_answers, id: question_with_answers.answers.first } }.to change(Answer, :count).by(-1) 
      end

      it 'redirect to parent question show' do 
        delete :destroy, params: { question_id: question_with_answers, id: question_with_answers.answers.first }
        expect(response).to redirect_to question_path(question_with_answers)
      end
    end
    
    context 'not users answer' do
      sign_in_user
      before { question_with_answers }

      it 'deletes answer' do 
        expect { delete :destroy, params: { question_id: question_with_answers, id: question_with_answers.answers.first } }.to_not change(Answer, :count)
      end

      it 'redirect to parent question show' do 
        delete :destroy, params: { question_id: question_with_answers, id: question_with_answers.answers.first }
        expect(response).to redirect_to question_path(question_with_answers)
      end
    end
  end
end
