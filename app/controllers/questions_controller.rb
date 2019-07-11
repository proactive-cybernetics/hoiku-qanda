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
      flash.now[:danger] = '質問を作成できませんでした 質問タイトルと内容を確認してください'
      render :new
    end
  end

  def index
    @questions = Question.where('status > 0').order('updated_at DESC')
    @questions.each { |q| q.content = q.content.truncate(200) }
  end
  
  def user_questions_index
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to home_path, danger: '存在しないユーザーです'
    end
    
    if @user.id == @current_user.id || !!@current_user.admin_auth
      # 同一ユーザの質問、または管理者権限では下書きも表示
      @questions = Question.where(user_id: params[:id]).order('updated_at DESC')
    else
      # 他のユーザの質問も表示できるが、下書きは表示しない
      @questions = Question.where("user_id = #{params[:id]} AND status > 0").order('updated_at DESC')
    end
  end
  
  def show
    @question = Question.find_by(id: params[:id])
    @answers = Answer.where(question_id: params[:id]).order('updated_at DESC')
  end
  
  private
  def question_params
    params.require(:question).permit(:title, :content, :status)
  end
end
