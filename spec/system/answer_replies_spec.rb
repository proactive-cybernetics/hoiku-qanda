require 'rails_helper'

describe '回答投稿機能' do
  let (:user_a) \
    { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let (:user_b) \
    { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }

  let! (:question_1) \
    { FactoryBot.create(:question, title: '最初の質問',\
                        content: '最初の質問です', user: user_b, status: 1) }

  let! (:the_answer) { FactoryBot.create(:answer, content: '最初の回答',\
                        user: user_a, question: question_1) }
  
  let (:login_user) {user_b}

  before do
    # ログインする
    visit login_path
    fill_in 'session[email]', with: login_user.email
    fill_in 'session[password]', with: login_user.password
    click_button 'ログイン'
  end                       

  it 'declines reply posts with blanc content' do

    visit new_reply_path(the_answer.id)
    fill_in 'answer_reply[content]', with: ''
    click_button '投稿'

    expect(page).to have_content('返信が作成できませんでした')    
  end
    
  it 'accepts reply posts by question poster' do

    visit new_reply_path(the_answer.id)
    fill_in 'answer_reply[content]', with: '回答内容です'
    click_button '投稿'

    expect(page).to have_content('回答内容です')    
  end
end
