require 'rails_helper'

describe '回答投稿機能' do
  let (:user_a) \
    { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let (:user_b) \
    { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }

  let! (:question_1) \
    { FactoryBot.create(:question, title: '最初の質問',\
                        content: '最初の質問です', user: user_b, status: 1) }
  before do
    # 質問者がユーザーBである、未公開の質問を作成しておく
    FactoryBot.create(:question, title: '未公開の質問', content: '工事中..', user: user_b, status: 0)
                            
    # ログインする
    visit login_path
    fill_in 'session[email]', with: login_user.email
    fill_in 'session[password]', with: login_user.password
    click_button 'ログイン'
  end                       
                        
  describe '回答投稿機能' do

    let (:login_user) {user_a}
    it 'accepts answer post with valid content' do
      visit new_answer_path(question_1.id)

      expect do
        fill_in 'answer[content]', with: "回答内容です"
        click_button '投稿'
      end.to change(Answer, :count).by(1)

    end
  end
end