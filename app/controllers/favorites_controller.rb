class FavoritesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @favorites = @user.favorite_questions.all
  end
  
  def create
    @question = Question.find(params[:question_id])
    @user = current_user
    @favorite = @user.favorites.build(question_id: @question.id)
    @favorite.save
  end

  def destroy
    @question = Question.find(params[:question_id])
    @favorite = current_user.favorites.find_by(question_id: params[:question_id])
    @favorite.destroy
  end
end
