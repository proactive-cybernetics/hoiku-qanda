require 'rails_helper'

describe '質問管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # ユーザーAを作成しておく
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      # ユーザーBを作成しておく
      user_b = FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')
      # 質問者がユーザーAである質問を作成しておく
      FactoryBot.create(:question, title: '最初の質問', content: '1ゲット!', user: user_a, status: 1)
      # 質問者がユーザーBである、未公開の質問を作成しておく
      FactoryBot.create(:question, title: '未公開の質問', content: '工事中..', user: user_b, status: 0)
    end
    
    context 'ユーザーAがログインしているとき' do
      before do
        # ユーザーAでログインする
        visit login_path
        fill_in 'session[email]', with: 'a@example.com'
        fill_in 'session[password]', with: 'password'
        click_button 'ログイン'
        
        # ログインしてから、質問一覧ページに移る
        visit questions_index_path
      end
    
      # ユーザーAが作成した質問が表示される
      it 'displays question published by user_a' do
        # 作成済みの質問の名称が画面上に表示されていることを確認
        expect(page).to have_content '最初の質問'
      end
      
      # 未公開の質問が表示されない
      it 'does not display unpublished question' do
        # 未公開の質問が表示されないことを確認
        expect(page).to have_no_content '未公開の質問'
      end
    end
  end
end
