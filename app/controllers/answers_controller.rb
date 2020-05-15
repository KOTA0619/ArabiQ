class AnswersController < ApplicationController
  before_action :require_user_logged_in
  
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
  
  private
  
  def answer_params
    params.require(:answer).permit(:content)
  end
end
