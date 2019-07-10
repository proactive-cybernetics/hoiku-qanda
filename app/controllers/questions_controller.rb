class QuestionsController < ApplicationController
  before_action :require_login
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to home_path, success: '質問を作成しました'
    else
      flash.now[:danger] = '質問を作成できませんでした 必須項目を確認してください'
      render :new
    end
  end

  def index
    @questions = Question.where('status > 0').order('updated_at DESC')
    @questions.each { |q| q.content = q.content.truncate(200) }
  end
  
  private
  def question_params
    params.require(:question).permit(:title, :content, :status)
  end
end
