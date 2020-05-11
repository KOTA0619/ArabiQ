class ToppagesController < ApplicationController
  def index
    @questions = Question.order(id: :desc).page(params[:page])
  end
end
