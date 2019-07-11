class AnswersController < ApplicationController
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
      redirect_to question_path(params[:answer][:question_id]), success: '回答を投稿しました'
    else
      redirect_to "/answers/new/#{params[:answer][:question_id]}", danger: '回答が作成できませんでした 内容が入力されているか確認してください'
    end
  end
  
  private
  def answer_params
    params.require(:answer).permit(:question_id, :content)
  end
end
