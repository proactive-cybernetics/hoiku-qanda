class AnswersController < ApplicationController
  before_action :require_login
  
  def new
    @question = Question.find_by(id: params[:id])
    if @question.nil?
      redirect_to questions_index_path, danger: '質問が存在しません'
    end
    @answer = Answer.new
  end
  
  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @answer.already_read = 0
    if @answer.save
      redirect_to question_path(params[:answer][:question_id]),\
        success: '回答を投稿しました'
    else
      redirect_to "/answers/new/#{params[:answer][:question_id]}",\
        danger: '回答が作成できませんでした 内容が入力されているか確認してください'
    end
  end
  
  def edit
    @answer = Answer.find_by(id: params[:id])
    @question = Question.find_by(id: @answer.question_id)
  end
  
  def update
    @answer = Answer.find_by(id: params[:answer][:id])
    
    @answer.content = params[:answer][:content]
    @answer.already_read = 1
    
    if @answer.user_id == @current_user.id || !!@current_user.admin_auth
      if @answer.save
        redirect_to question_path(@answer.question_id,\
          success: '回答を修正しました')
      else
        redirect_to question_path(@answer.question_id,\
          danger: '回答の修正に失敗しました')
      end
    else
      redirect_to question_path(@answer.question_id,\
        danger: '回答の修正は回答した本人または管理者のみ行えます')
    end
  end
  
  def destroy
    @answer = Answer.find_by(id: params[:id])
    
    @answer.content = 'この回答は削除されました'
    @answer.already_read = 1
    @answer.deletion_flg = 1
    
    if @answer.user_id == @current_user.id || !!@current_user.admin_auth
      if @answer.save
        redirect_to question_path(@answer.question_id,\
          success: '回答を削除しました')
      else
        redirect_to question_path(@answer.question_id,\
          danger: '回答の削除に失敗しました')
      end
    else
      redirect_to question_path(@answer.question_id,\
        danger: '回答の削除は回答した本人または管理者のみ行えます')
    end
  end
  
  private
  def answer_params
    params.require(:answer).permit(:question_id, :content)
  end
end
