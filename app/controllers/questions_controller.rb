class QuestionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]
  
  def show
    @question = Question.find(params[:id])
  end
  
  def new
    @question = current_user.questions.build
  end
  
  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = '質問を投稿しました。'
      redirect_to @question
    else
      flash[:danger] = '質問の投稿に失敗しました。'
      render :new
    end
  end
  
  private
  
  def question_params
    params.require(:question).permit(:content, :title)
  end
end
