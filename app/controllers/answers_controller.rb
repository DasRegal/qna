class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_answer, only: [ :destroy ]
  
  def index
  end
  
  def new
    @answer = Answer.new
  end
  
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
      redirect_to question_path(@question)
    else
      render :new
    end
  end
  
  def destroy
    question = Question.find(params[:question_id])
    if is_author?(@answer)
      @answer.destroy
      flash[:notice] = 'Your answer is deleted.'
    else
      flash[:notice] = 'You are not the author.'
    end
    redirect_to question_path(question)
  end
  
  private
  
  def load_answer
    @answer = Answer.find(params[:id])
  end
  
  def answer_params
    params.require(:answer).permit(:title, :body)
  end
  
  def is_author?(answer)
    if answer.user_id == current_user.id
      return true
    else
      return false
    end
  end
  
end
