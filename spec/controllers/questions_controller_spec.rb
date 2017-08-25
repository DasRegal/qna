require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }
  let(:user_with_questions) { create(:user, :with_questions) }
  
  describe 'GET #new' do
    sign_in_user
    
    before { get :new }
    
    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end
    
    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    
    context 'with valid attributes' do
      it 'saves a new question in the database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end
      
      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
    
    context 'vith invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end
      
      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end
  
  describe 'DELETE #destroy' do
    context 'If user is author' do
      sign_in_user
      before { question.update(user_id: @user.id) }
      
      it 'deletes question' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end
      
      it 'redirect to index' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end
    
    context 'If user is not author' do
      sign_in_user
      it 'deletes question' do
        question
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end
      
      it 'redirect to index' do
        delete :destroy, params: { id: question }
        expect(response).to render_template :show
      end
    end
    
  end
end
