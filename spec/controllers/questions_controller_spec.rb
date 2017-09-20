require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }
  let(:questions) { create_list(:question, 10) }
  let(:user_with_questions) { create(:user, :with_questions) }
  
  describe 'GET #index' do
    before { get :index }
    
    it 'populates in array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
    
    it 'render index view' do
      expect(response).to render_template :index
    end
  end
  
  describe 'GET #show' do
    before { get :show, params: { id: question } }
    
    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    
    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    
    it 'builds new attachment for answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end
    
    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
  
  describe 'GET #new' do
    sign_in_user
    
    before { get :new }
    
    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end
    
    it 'builds new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
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
      
      it 'check current_user is author' do 
        post :create, params: { question: attributes_for(:question) }
        expect(assigns(:question).user).to eq @user
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
