require 'rails_helper'

describe '新規ユーザー登録機能', type: :system do
  it 'is possible to create new user' do
    visit new_user_path
    expect do
      fill_in 'user[name]', with: '新規ユーザー'
      fill_in 'user[email]', with: 'foo@bar.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button('登録')
    end.to change(User, :count).by(1)
  end
end

describe 'ユーザー情報表示機能', type: :system do
  let! (:user_a) \
    { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com',\
        profile: 'ユーザーえーでーす') }
  let! (:user_b) \
    { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com',\
        profile: 'ユーザービーでございます') }
  
  before do
    visit login_path
    fill_in 'session[email]', with: login_user.email
    fill_in 'session[password]', with: login_user.password
    click_button 'ログイン'
  end
  
  describe 'ユーザーホーム表示機能' do
    let (:login_user) {user_a}

    it "has valid title, name of login user, and links for new question and edit user profile" do
      visit home_path
      expect(page).to have_title("ホーム")
      expect(page).to have_content(login_user.name)
      expect(page).to have_link('新しい質問を作成する', href: questions_new_path)
      expect(page).to have_link('プロフィールと設定を変更する', href: edit_user_path(login_user.id))
    end
  end

  describe 'ユーザー情報編集機能' do
    let (:login_user) {user_a}

    it 'accepts edit with valid name, email, title setting, profile, and password' do
      visit edit_user_path(login_user.id)
      expect(page).to have_title('プロフィール編集')
      expect(page).to have_content(login_user.name)

      fill_in('user[name]', with: 'ゆーざーA')
      check('user[title_setting]')
      fill_in('user[profile]', with: 'ユーザーAのプロフィールです。')
      fill_in('user[password]', with: login_user.password)
      fill_in('user[password_confirmation]', with: login_user.password)
      click_button('更新')

      expect(page).to have_content('更新が完了しました')
      expect(page).to have_content('ゆーざーA')
    end

    it 'declines edit with defferent password confirmation' do
      visit edit_user_path(login_user.id)
      fill_in('user[name]', with: 'ゆーざーA')
      check('user[title_setting]')
      fill_in('user[profile]', with: 'ユーザーAのプロフィールです。')
      fill_in('user[password]', with: login_user.password)
      fill_in('user[password_confirmation]', with: '')
      click_button('更新')

      expect(page).to have_content('更新に失敗しました')
    end
  end
  
  describe 'ユーザー一覧表示機能' do
    let (:login_user) {user_a}
    
    before do
      visit 'users'
    end
    
    it 'dispalys names of all users' do
      expect(page).to have_content 'ユーザーA'
      expect(page).to have_content 'ユーザーB'
    end
  end
  
  describe 'ユーザー詳細表示機能' do
    let (:login_user) {user_a}
    
    it 'displays informations of user_a' do
      visit user_path(user_a)
      
      expect(page).to have_content 'ユーザーA'
      expect(page).to have_content 'ユーザーえーでーす'
    end
    
    it 'displays informations of user_b' do
      visit user_path(user_b)
      
      expect(page).to have_content 'ユーザーB'
      expect(page).to have_content 'ユーザービーでございます'
    end
  end

  describe 'ユーザー退会機能' do
    let (:login_user) {user_a}

    it 'is possible to unsubscribe hoiku-qanda' do
      visit edit_user_path(user_a)
      click_link('退会する')
      fill_in 'user[password]', with: login_user.password
      fill_in 'user[password_confirmation]', with: login_user.password
      click_button('退会')

      expect(page).to have_content '退会処理が完了しました'
    end
  end
end
