class AnswerRepliesController < ApplicationController
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
      redirect_to question_path(params[:answer_reply][:question_id]), success: '回答を投稿しました'
    else
      redirect_to "/answer_reply/new/#{params[:answer_reply][:question_id]}", danger: '回答が作成できませんでした 内容が入力されているか確認してください'
    end
  end
  
  private
  # 新規登録時に使用するStrong parameter
  def answer_reply_params
    params.require(:answer_reply).permit(:answer_id, :content)
  end
end
