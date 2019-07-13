class AnswerRepliesController < ApplicationController
  def new
    @answer = Answer.find_by(id: params[:id])
    @reply = AnswerReply.new
  end

  def create
    @reply = AnswerReply.new(answer_reply_params)
    @reply.already_read = 0
    if @reply.save
      redirect_to question_path(params[:answer_reply][:question_id]), success: '回答を投稿しました'
    else
      redirect_to "/answer_reply/new/#{params[:answer_reply][:question_id]}", danger: '回答が作成できませんでした 内容が入力されているか確認してください'
    end
  end
  
  private
  def answer_reply_params
    params.require(:answer_reply).permit(:answer_id, :content)
  end
end
