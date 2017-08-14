require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:questions) {  create_list(:question, 2) }
  let(:question) { create(:question) }
  
  describe 'GET #index' do
    before { get :index }
    
    it 'populates in array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
    
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
  
  describe 'GET #show' do
    before do
      get :show, params: { id: question }
    end
    
    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    
    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
  
  describe 'GET #new' do
    before { get :new }
    
    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end
    
    it 'render new view' do
      expect(response).to render_template :new
    end
  end
  
  describe 'GET #edit' do
    before do
      get :edit, params: { id: question}
    end
    
    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    
    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end
  
  describe 'POST #create' do
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
  
  describe 'PATCH #update' do
    context 'vith valid attributes' do
      it 'assigns the requested question to @qestion' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end
      
      it 'change question attributes' do
        patch :update, params: { id: question, question: { title: 'New title', body: 'New body' } }
        question.reload
        expect(question.title).to eq 'New title'
        expect(question.body).to  eq 'New body'
      end
      
      it 'requires to the update question' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(response).to redirect_to question
      end
    end
    
    context 'vith invalid attributes' do
      before { patch :update, params: { id: question, question: { title: 'New title', body: nil } } }
      it 'does not change question attributes' do
        question.reload
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end
      
      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end
  
  describe 'DELETE #destroy' do
    before { question }
    
    it 'deletes question' do
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
    end
    
    it 'redirect to index' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to question_path
    end
    
  end
end