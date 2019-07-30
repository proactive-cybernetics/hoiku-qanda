require 'rails_helper'

# 参考文献 :
#  大場 寧子 et al., 「現場で使える Ruby on Rails 5 速習実践ガイド」,
#  マイナビ出版, ISBN978-4-8399-6222-7, Oct. 2018, pp. 199-205.

describe '質問管理機能', type: :system do
  let (:user_a) \
    { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let (:user_b) \
    { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let! (:question_1) \
    { FactoryBot.create(:question, title: '最初の質問',\
                        content: '1ゲット!', user: user_a, status: 1) }
  
  before do
    # 質問者がユーザーAである質問を作成しておく
    # 質問者がユーザーBである、未公開の質問を作成しておく
    FactoryBot.create(:question, title: '未公開の質問', content: '工事中..', user: user_b, status: 0)
    
    # ログインする
    visit login_path
    fill_in 'session[email]', with: login_user.email
    fill_in 'session[password]', with: login_user.password
    click_button 'ログイン'
  end
  
  shared_examples_for 'displays question published by user_a' do
    # 作成済みの質問の名称が画面上に表示されていることを確認
    it { expect(page).to have_content '最初の質問' }
  end
    
  describe '一覧表示機能' do
    before do
      # ログインしてから、質問一覧ページに移る
      visit questions_index_path
    end
    
    context 'when user_a is logged in' do
      let (:login_user) { user_a }
    
      # ユーザーAが作成した質問が表示される
      it_behaves_like 'displays question published by user_a'
      
      # 未公開の質問が表示されない
      it 'does not display unpublished question' do
        # 未公開の質問が表示されないことを確認
        expect(page).to have_no_content '未公開の質問'
      end
    end
  end
  
  describe '詳細表示機能' do
    before do
      visit question_path(question_1)
    end
    
    context 'when user_a is logged in' do
      let (:login_user) { user_a }

      # ユーザーAが作成した質問が表示される
      it_behaves_like 'displays question published by user_a'
    end
  end
end
