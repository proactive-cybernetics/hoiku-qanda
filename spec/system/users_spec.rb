require 'rails_helper'

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
      visit users_path(user_a)
      
      expect(page).to have_content 'ユーザーA'
      expect(page).to have_content 'ユーザーえーでーす'
    end
    
    it 'displays informations of user_b' do
      visit users_path(user_b)
      
      expect(page).to have_content 'ユーザーB'
      expect(page).to have_content 'ユーザービーでございます'
    end
  end
end
