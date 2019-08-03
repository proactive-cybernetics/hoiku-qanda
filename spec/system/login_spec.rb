require 'rails_helper'

describe 'ログイン機能', type: :system do
  let! (:user_a) \
    { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  
  
  it 'decline login for invalid information' do
    visit login_path
    fill_in 'session[email]', with: ''
    fill_in 'session[password]', with: ''
    click_button 'ログイン'
    
    # ログイン失敗メッセージが表示されること
    expect(page).to have_content 'ログインに失敗しました'
  end
  
  it 'accept login for valid information' do
    
    visit login_path
    fill_in 'session[email]', with: user_a.email
    fill_in 'session[password]', with: user_a.password
    click_button 'ログイン'
    
    # ログイン成功メッセージが表示され
    # 遷移先のホーム画面で、ユーザー名が表示されること
    expect(page).to have_content 'ログインに成功しました'
    expect(page).to have_content 'ユーザーA'
  end
  
  it 'accept login with valid information followed by logout' do
    visit login_path
    fill_in 'session[email]', with: user_a.email
    fill_in 'session[password]', with: user_a.password
    click_button 'ログイン'
    
    # ログアウト処理
    click_link 'ログアウト'
    
    # 遷移先のページで、ユーザー名が表示されないこと
    expect(page).to have_no_content 'ユーザーA'
  end
end