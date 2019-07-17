class AnswerRepliesController < ApplicationController
  before_action :require_login
  
  # 回答への返信の作成画面を表示する
  def new
    @answer = Answer.find_by(id: params[:id])
    @reply = AnswerReply.new
  end

  # 回答への返信をデータベースに新規登録する
  def create
    @reply = AnswerReply.new(answer_reply_params)
    # 既読フラグを初期化 (0 : 未読)
    @reply.already_read = 0
    if @reply.save
      redirect_to question_path(params[:answer_reply][:question_id]),\
        success: '返信を投稿しました'
    else
      redirect_to "/answer_reply/new/#{params[:answer_reply][:question_id]}",\
        danger: '返信が作成できませんでした 内容が入力されているか確認してください'
    end
  end
  
  # 回答への返信を論理削除
  def destroy
    @reply = AnswerReply.find_by(id: params[:id])
    
    @reply.content = 'この返信は削除されました'
    @reply.deletion_flg = 1
    
    if @reply.answer.question.user_id == @current_user.id ||\
      !!@current_user.admin_auth
      if @reply.save
        redirect_to question_path(@reply.answer.question_id,
          success: '返信を削除しました')
      else
        redirect_to question_path(@reply.answer.question_id,
          danger: '返信の削除に失敗しました')
      end
    else
      redirect_to question_path(@reply.answer.question_id,\
          danger: '返信の削除は、返信を行った本人または管理者のみが行えます')
    end
  end
  
  private
  # 新規登録時に使用するStrong parameter
  def answer_reply_params
    params.require(:answer_reply).permit(:answer_id, :content)
  end
end
