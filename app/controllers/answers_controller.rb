class AnswersController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
    question = Question.find(params[:question_id])
    @answer = question.answers.build
    @answer.user_id = current_user.id
  end

  def create
    question = Question.find(params[:question_id])
    @answer = question.answers.build(answer_params)
    @answer.user_id = current_user.id
    
    if @answer.save
      flash[:success] = '返信しました。'
      redirect_to question_path(@answer.question_id)
    else 
      flash.now[:danger] = '返信に失敗しました。'
      render :new
    end
  end
  
  def edit
    question = Question.find(params[:question_id])
    @answer = Answer.find_by(question_id: question.id)
  end
  
  def update
    question = Question.find(params[:question_id])
    @answer = Answer.find_by(question_id: question.id)
    
    if @answer.update(answer_params)
      flash[:success] = '変更が保存されました。'
      redirect_to question_path(@answer.question_id)
    else
      flash[:danger] = '変更に失敗しました。'
      render :edit
    end
  end
  
  def destroy
     @answer = Answer.find(params[:answer_id])
     
     @answer.destroy
     flash[:success] = '返信を削除しました。'
     redirect_to question_url
  end
  
  private
  
  def answer_params
    params.require(:answer).permit(:content)
  end
  
  def correct_user
    @answer = Answer.find_by(user_id: current_user.id)
    unless @answer
      redirect_to root_url
    end
  end
end
