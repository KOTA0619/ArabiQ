class QuestionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  
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
  
  def edit
  end
  
  def update
    
    if @question.update(question_params)
      flash[:success] = '変更を保存しました。'
      redirect_to @question
    else
      flash[:danger] = '変更に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @question.destroy
    
    flash[:success] = '質問を削除しました。'
    redirect_to root_url
  end
  
  def search
    @questions = Question.search(params[:search])
  end
  
  private
  
  def question_params
    params.require(:question).permit(:content, :title)
  end
  
  def correct_user
    @question = current_user.questions.find_by(id: params[:id])
    unless @question
      redirect_to root_url
    end
  end
end
