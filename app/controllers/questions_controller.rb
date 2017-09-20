class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_question, only: [ :show, :destroy, :update ]
  
  def index
    @questions = Question.all
  end
  
  def show
    @answer = Answer.new
    @answer.attachments.build
  end
  
  def new
    @question = Question.new
    @question.attachments.build
  end
  
  def update
    if current_user.author_of?(@question)
      @question.update(question_params)
      flash[:notice] = 'Your question is updated.'
    else
      flash[:notice] = 'You are not the author.'
    end
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end
  
  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      flash[:notice] = 'Your question is deleted.'
      redirect_to questions_path
    else
      flash[:notice] = 'You are not the author.'
      render :show
    end
  end
  
  private
  
  def load_question
    @question = Question.find(params[:id])
  end
 
  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end
end
