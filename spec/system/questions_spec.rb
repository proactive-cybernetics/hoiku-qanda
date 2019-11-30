require 'rails_helper'

# 参考文献 :
#  大場 寧子 et al., 「現場で使える Ruby on Rails 5 速習実践ガイド」,
#  マイナビ出版, ISBN978-4-8399-6222-7, Oct. 2018, pp. 199-205.

describe '質問管理機能', type: :system do
  let (:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let (:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let (:admin) { FactoryBot.create(:user, name: '管理人', )}

  # 質問者がユーザーAである質問を作成しておく
  let! (:question_1) \
    { FactoryBot.create(:question, title: '最初の質問',\
                        content: '1ゲット!', user: user_a, status: 1) }
  
  # 回答者がユーザーBである回答を作成しておく
  let! (:answer_1) \
    { FactoryBot.create(:answer, content: '最初の回答',\
                        user: user_b, question: question_1) }
  
  before do
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

  describe '質問投稿機能' do
    let (:login_user) { user_a }
    
    it 'accepts post with valid title, content, and publish setting' do
      expect do
        visit questions_new_path
        fill_in 'question[title]', with: "タイトル"
        fill_in 'question[content]', with: "質問内容"
        select '下書き(公開しない)', from: 'question[status]' 
        click_button '投稿'
      end.to change(Question, :count).by(1)
    end

    it 'declines post with blank title' do
      expect do
        visit questions_new_path
        fill_in 'question[title]', with: ""
        fill_in 'question[content]', with: "質問内容"
        select '下書き(公開しない)', from: 'question[status]' 
        click_button '投稿'
      end.to change(Question, :count).by(0)

      # エラーメッセージが表示されること
      expect(page).to have_content '質問を作成できませんでした 質問タイトルと内容を確認してください'
    end
  end
  
  # 自分が作成した既存の質問を編集できること
  describe '質問編集機能' do
    let (:login_user) { user_a }
    
    it 'accepts patch with valid title, content, and publish setting' do
      visit edit_question_path(question_1)
      fill_in 'question[title]', with: "タイトル!"
      fill_in 'question[content]', with: "質問内容!"
      select '回答募集中', from: 'question[status]'
      click_button '更新'

      # 質問一覧ページに、更新された質問内容が表示されること
      visit questions_index_path
      expect(page).to have_content('タイトル!')
      expect(page).to have_content('質問内容!')
    end

    it 'declines post with blank title' do
      visit edit_question_path(question_1)
      fill_in 'question[title]', with: ""
      fill_in 'question[content]', with: "質問内容!"
      select '回答募集中', from: 'question[status]' 
      click_button '更新'

      # エラーメッセージが表示されること
      expect(page).to have_content '更新に失敗しました。必須項目を確認してください'
    end
  end

  describe '質問削除機能' do
    let (:login_user) { user_a }

    it 'is possible to delete own question' do
      visit edit_question_path(question_1)

      click_link('質問の削除はこちら')
      # 削除の確認ページに遷移するので、更にリンクをクリック
      click_link('削除する')

      visit questions_index_path
      # 削除した質問(論理削除済み)のタイトルが表示されないこと
      expect(page).to have_no_content(question_1.title)
    end
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

    # キーワード検索
    context 'when any search keyword is specified' do
      let (:login_user) {user_a}

      it 'displays questions which includes keywords in title or content' do
        FactoryBot.create(:question, title: 'ふたつめの質問',\
                        content: 'foo bar', user: user_a, status: 1)
        FactoryBot.create(:question, title: 'みっつめの質問',\
                        content: 'foo hoge', user: user_a, status: 1)
        
        visit '/questions/index?search=foo'
        expect(page).to have_content('ふたつめの質問')
        expect(page).to have_content('みっつめの質問')
        expect(page).to have_no_content('最初の質問')
      end
    end
  end
  
  describe 'ユーザー別一覧表示機能' do
    before do
      # ログインしてから、ユーザーAの質問一覧ページに移る
      visit user_questions_index_path(user_a)
    end
    
    context 'when user_b is logged in' do
      let (:login_user) { user_b }

      # ユーザーAが作成した質問が表示される
      it_behaves_like 'displays question published by user_a'
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
      
      it 'displays content of question' do
        expect(page).to have_content '最初の質問'
      end
      
      # ユーザーBの投稿した回答が表示される
      it 'displays content of answer' do
        expect(page).to have_content '最初の回答'
      end
    end
  end
end
